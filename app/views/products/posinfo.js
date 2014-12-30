$("#relatedproducts").html("<%= escape_javascript(render partial: 'relatedpositems', :object => { :relatedproducts => @relatedproducts, :product => @product}) %>");
$('#relatedpositems').foundation('reveal', 'open');
loading(false);
