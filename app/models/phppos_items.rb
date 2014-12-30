  class PhpposItems < ActiveRecord::Base
  require 'net/https'
    establish_connection(
    :adapter  => "mysql2",
    :host     => "localhost",
    :username => "root",
    :pool => 5,
    :password => "root",
    :database => "bitnami_phppos",
    :encoding => 'utf8'
  )
   
   has_many :saleitems,
   :class_name => "PhpposSalesItems",
   :foreign_key => :item_id

   has_one :supplier,
   :class_name => "PhpposSuppliers",
   :foreign_key => :person_id,
   :primary_key => :supplier_id


    attr_accessor :studio

  def self.items_like name
  return self.search do
      
      fulltext name do
        query_phrase_slop 3
      end
  end
  end

  def self.update_images 
  suckr = ImageSuckr::GoogleSuckr.new
  self.all.each do |product|
    product.image_src = suckr.get_image_url({"q" => product.item_number})
    product.save
  end
  end

  def self.sex_toy
  found = 0
  notfound = 0
PhpposItems.all.each do |product|
begin
p = Product.where(["phppos_item_item_number = ?",product.item_number])
rescue 
next
end 

unless p.blank?
found = found + 1
product.image_src = p[0].image_src 
product.save
logger.warn("Image Found:"+found.to_s)
end

end
logger.warn("Found:"+found.to_s+" / Not Found:"+notfound.to_s)
end

  def self.remote_image 
  found = 0
  notfound = 0
  require "uri"

  @products = PhpposItems.where(["supplier_id=?",10])


   @products.each do |img|

    begin
      a = Nokogiri::HTML(open("http://www.pinkcherry.ca/catalogsearch/result/?dir=desc&q="+img.item_number))
   rescue => error
     logger.warn(error.inspect)
   end
    

     b = a.at_css("#mainimage")


   unless b.blank? || b.nil?
        img.image_src = b.values[1]
        img.save
        found = found + 1
        logger.warn("Found (" + found.to_s + "):" + img.name)
        logger.warn(b.values[1])
      else
        img.image_src = "http://www.24houradultmart.com/Coming%20Soon.png"
        img.save
        notfound = notfound + 1
        logger.warn("Not Found (" + notfound.to_s + "):")
      end

   end

  end


  def self.remote_jds 

  found = 0
  notfound = 0
  cookieString = "osCsid=cf664a0df73595bff089b8d6d409058a; _ga=GA1.2.982698028.1419280612; _gat=1"
  require "uri"
=begin
   ppage = open("http://www.jdswholesales.com/catalog/product_info.php?manufacturers_id=76&products_id=13385&osCsid=f9a36f999f46fea599c4ee3f9ca0e641", "Cookie" => "osCsid=cf664a0df73595bff089b8d6d409058a; _ga=GA1.2.982698028.1419280612; _gat=1")

            product_page = Nokogiri::HTML(ppage)
            logger.warn(product_page.css(".productlisting-headingPrice").text) 

             logger.warn(product_page.css(".main_table_heading_inner td")[0].text) 
             logger.warn(product_page.css(".main_table_heading_inner td")[2].children.text) 
             logger.warn(product_page.css(".main_table_heading_inner img")[4].values[0]) 

  #curl = Curl.post("http://www.jdswholesales.com/catalog/login.php?action=process", {:email_address => '24hourmart@gmail.com', :password => '540yonge'})
  #curl.follow_location = true
  #curl.enable_cookies = true
exit
=end
  curl = Curl::Easy.new
["http://www.jdswholesales.com/catalog/index.php?manufacturers_id=76"].map do |url|


  mpage = open(url, "Cookie" => cookieString)



  loop do

    begin
      mpagemodel = Nokogiri::HTML(mpage)
    rescue => error
      logger.warn(error.inspect)
    end

    products = mpagemodel.css(".productListing-data a")
    manufacturer = mpagemodel.css(".pageHeading").text

logger.warn("Products Size")
logger.warn(products.size)

    products.each do |product|
      logger.warn(product.values[0])

if product.values[0].index('osCsid') 
       ppageURL = product.values[0][0,product.values[0].index('osCsid')] 
else
ppageURL = product.values[0]
end

       ppage = Curl::Easy.new(ppageURL)

      begin
            ppage = open(ppageURL, "Cookie" => cookieString)

            product_page = Nokogiri::HTML(ppage)
           # logger.warn(product_page.css(".productlisting-headingPrice").text) 
           # logger.warn(product_page.css(".main_table_heading_inner td")[0].text) 
           #  logger.warn(product_page.css("td.main table p").text) 
           # logger.warn(product_page.css(".pageHeading span").text)
            # logger.warn( product_page.css(".main_table_heading_inner img")[4].values[0] ) 
            
             saveme = Product.new 
             saveme.variant_price = product_page.css(".productlisting-headingPrice").text
             logger.warn("a")
             saveme.title = product_page.css(".main_table_heading_inner td")[0].text
                          logger.warn("b")

             saveme.body_html = product_page.css("td.main table p").text
             saveme.item_number = product_page.css(".pageHeading span").text
                          logger.warn("c")

             saveme.image_src = 'http://www.jdswholesales.com/catalog/' + product_page.css(".main_table_heading_inner img")[4].values[0] unless product_page.css(".main_table_heading_inner img")[4].nil?
             saveme.manufacturer = manufacturer
             saveme.provider_id = 8
             saveme.save
             found = found + 1
             logger.warn("JDS IMPORT COUNT")
             logger.warn(found)

              
             
              rescue => error
                logger.warn("STUPID ERROR")
                return product_page
                logger.warn(error.inspect)
              end
             
        end # products.each do

logger.warn("END PRODUCTS > EACH DO")

        #Find The Next Link
        nextlink = mpagemodel.css(".pageResults")
logger.warn("NEXXXXXXXXXXXXXXXXT LINK")
logger.warn(nextlink)
if nextlink[nextlink.length - 1].values[0].nil?
          mpage = nil 
        else
       uurl = nextlink[nextlink.length - 1].values[0]
       logger.warn(uurl)
       logger.warn("DDDEEEFFF")
        mpage = open(uurl, "Cookie" => cookieString)
       end
      

if mpage.nil? 
logger.warn("MPAGE NIL")
break
else
logger.warn("New PAGE")
logger.warn(uurl)
end

  end # end loop do

  end # MAP 
  end #FUNCTION REMOTE JDS

  def last_order format=true

    order = PhpposReceivingsItems.where(["item_id =?",self.item_id]).joins(:receiving).order("receiving_time DESC").limit(1)
    return order[0].receiving.receiving_time unless format == true
    return order[0].receiving.receiving_time.strftime("%y %m %d") unless order.blank?
    return "NA"

  end

  def last_sale format=true
  sale_item = PhpposSalesItems.where(["item_id = ?",self.item_id]).limit(1)
  return PhpposSales.where(["sale_id =?",sale_item[0].sale_id])[0].sale_time unless format == true
  return PhpposSales.where(["sale_id =?",sale_item[0].sale_id])[0].sale_time.strftime("%y %m %d")  unless sale_item.blank?
  return "NA"
  end

  def distributor_name
  a = PhpposSuppliers.where(["person_id=?",self.supplier_id])[0]

  return a.company_name unless a.blank?
  return "NA"

  end

  def stock 
  return self.quantity
  end

  def backstock 
  item = PhpposItems.where("item_number = ?", "sr" + self.item_number)[0] unless self.item_number.blank?

  return item.quantity unless item.blank?
  return "n/a"

  end

  def sales
  return self.saleitems.size
  end

  def self.random_number
  count = 0 
  array = [1919367,4140689,978373,6199042,5990222,2566121,9779477,8210347,4282355,3139838]

  loop do
  num = Random.rand(99999...10000000)
  count = count + 1
  break if array.include?(num)
  end

  end


  def self.adult_dvd_catalog

    begin
    stag_shop = open("http://www.adultdvdmarketplace.com/catalog_0.html")
    rescue
    continue
    end


    doc = Nokogiri::HTML(stag_shop)
    css = "a"
    scraped_links = doc.css(css)
    html = ""
    catalog_links = []

    scraped_links.each do |anchor|
      catalog_links.push "http://www.adultdvdmarketplace.com" + anchor.attributes['href'].value 
    end



  #Find Every Item
    catalog_links.each_with_index do | catalog_link, index |
     
    
    if(index > 139)
        begin
        catalog = open(catalog_link)
        rescue 
        continue
        end  
          doc = Nokogiri::HTML(catalog)
          css = "a"


          single_catalog_page = doc.css(css)
          catalog_page_links = [] 
        
          single_catalog_page.each do |single_catalog_page_link|
          catalog_page_links.push "http://www.adultdvdmarketplace.com" + single_catalog_page_link.attributes['href'].value
          page_link = AdultDvdMarketplace.new
          page_link.link = "http://www.adultdvdmarketplace.com" + single_catalog_page_link.attributes['href'].value
          page_link.save

        end



          catalog_page_links.each do |catalog_page_link|
            
            begin
              dvdpage = open(catalog_page_link)
            rescue
              continue
            end
              doc = Nokogiri::HTML(dvdpage)
              css = ".GrayDialogTitle"
              title = doc.css(css).text
              css = ".DarkGrayTable"
              table = doc.css(css)

              css = ".GrayDialogBody"
              description = doc.xpath('//*[@itemprop="description"]').text
              image = doc.xpath('//*[@width="200"]').children[1].attributes["src"].value


              product = Product.new
              product.title = title
              product.studio = table[3].text unless table[3].blank?
              product.release_date = table[5].text unless table[5].blank?
              product.variant_sku = table[7].text unless table[7].blank?
              product.variant_barcode = table[9].text unless table[9].blank?
              product.category_3 = table[11].text unless table[11].blank?
              product.body_html = description unless description.blank?
              product.image_src = doc.xpath('//*[@width="200"]').children[1].attributes["src"].value
              product.provider_id = 2
              product.save 
            end

  end

      end


  end




  end
