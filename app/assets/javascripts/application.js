// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .
//= require select2
/* tooltipsy by Brian Cray
* Lincensed under GPL2 - http://www.gnu.org/licenses/gpl-2.0.html
* Option quick reference:
* - alignTo: "element" or "cursor" (Defaults to "element")
* - offset: Tooltipsy distance from element or mouse cursor, dependent on alignTo setting. Set as array [x, y] (Defaults to [0, -1])
* - content: HTML or text content of tooltip. Defaults to "" (empty string), which pulls content from target element's title attribute
* - show: function(event, tooltip) to show the tooltip. Defaults to a show(100) effect
* - hide: function(event, tooltip) to hide the tooltip. Defaults to a fadeOut(100) effect
* - delay: A delay in milliseconds before showing a tooltip. Set to 0 for no delay. Defaults to 200
* - css: object containing CSS properties and values. Defaults to {} to use stylesheet for styles
* - className: DOM class for styling tooltips with CSS. Defaults to "tooltipsy"
* - showEvent: Set a custom event to bind the show function. Defaults to mouseenter
* - hideEvent: Set a custom event to bind the show function. Defaults to mouseleave
* Method quick reference:
* - $('element').data('tooltipsy').show(): Force the tooltip to show
* - $('element').data('tooltipsy').hide(): Force the tooltip to hide
* - $('element').data('tooltipsy').destroy(): Remove tooltip from DOM
* More information visit http://tooltipsy.com/
*/
;(function(a){a.tooltipsy=function(c,b){this.options=b;this.$el=a(c);this.title=this.$el.attr("title")||"";this.$el.attr("title","");this.random=parseInt(Math.random()*10000);this.ready=false;this.shown=false;this.width=0;this.height=0;this.delaytimer=null;this.$el.data("tooltipsy",this);this.init()};a.tooltipsy.prototype={init:function(){var e=this,d,b=e.$el,c=b[0];e.settings=d=a.extend({},e.defaults,e.options);d.delay=+d.delay;if(typeof d.content==="function"){e.readify()}if(d.showEvent===d.hideEvent&&d.showEvent==="click"){b.toggle(function(f){if(d.showEvent==="click"&&c.tagName=="A"){f.preventDefault()}if(d.delay>0){e.delaytimer=window.setTimeout(function(){e.show(f)},d.delay)}else{e.show(f)}},function(f){if(d.showEvent==="click"&&c.tagName=="A"){f.preventDefault()}window.clearTimeout(e.delaytimer);e.delaytimer=null;e.hide(f)})}else{b.bind(d.showEvent,function(f){if(d.showEvent==="click"&&c.tagName=="A"){f.preventDefault()}e.delaytimer=window.setTimeout(function(){e.show(f)},d.delay||0)}).bind(d.hideEvent,function(f){if(d.showEvent==="click"&&c.tagName=="A"){f.preventDefault()}window.clearTimeout(e.delaytimer);e.delaytimer=null;e.hide(f)})}},show:function(i){if(this.ready===false){this.readify()}var b=this,f=b.settings,h=b.$tipsy,k=b.$el,d=k[0],g=b.offset(d);if(b.shown===false){if((function(m){var l=0,e;for(e in m){if(m.hasOwnProperty(e)){l++}}return l})(f.css)>0){b.$tip.css(f.css)}b.width=h.outerWidth();b.height=h.outerHeight()}if(f.alignTo==="cursor"&&i){var j=[i.clientX+f.offset[0],i.clientY+f.offset[1]];if(j[0]+b.width>a(window).width()){var c={top:j[1]+"px",right:j[0]+"px",left:"auto"}}else{var c={top:j[1]+"px",left:j[0]+"px",right:"auto"}}}else{var j=[(function(){if(f.offset[0]<0){return g.left-Math.abs(f.offset[0])-b.width}else{if(f.offset[0]===0){return g.left-((b.width-k.outerWidth())/2)}else{return g.left+k.outerWidth()+f.offset[0]}}})(),(function(){if(f.offset[1]<0){return g.top-Math.abs(f.offset[1])-b.height}else{if(f.offset[1]===0){return g.top-((b.height-b.$el.outerHeight())/2)}else{return g.top+b.$el.outerHeight()+f.offset[1]}}})()]}h.css({top:j[1]+"px",left:j[0]+"px"});b.settings.show(i,h.stop(true,true))},hide:function(c){var b=this;if(b.ready===false){return}if(c&&c.relatedTarget===b.$tip[0]){b.$tip.bind("mouseleave",function(d){if(d.relatedTarget===b.$el[0]){return}b.settings.hide(d,b.$tipsy.stop(true,true))});return}b.settings.hide(c,b.$tipsy.stop(true,true))},readify:function(){this.ready=true;this.$tipsy=a('<div id="tooltipsy'+this.random+'" style="position:fixed;z-index:2147483647;display:none">').appendTo("body");this.$tip=a('<div class="'+this.settings.className+'">').appendTo(this.$tipsy);this.$tip.data("rootel",this.$el);var c=this.$el;var b=this.$tip;this.$tip.html(this.settings.content!=""?(typeof this.settings.content=="string"?this.settings.content:this.settings.content(c,b)):this.title)},offset:function(b){return this.$el[0].getBoundingClientRect()},destroy:function(){if(this.$tipsy){this.$tipsy.remove();a.removeData(this.$el,"tooltipsy")}},defaults:{alignTo:"element",offset:[0,-1],content:"",show:function(c,b){b.fadeIn(100)},hide:function(c,b){b.fadeOut(100)},css:{},className:"tooltipsy",delay:200,showEvent:"mouseenter",hideEvent:"mouseleave"}};a.fn.tooltipsy=function(b){return this.each(function(){new a.tooltipsy(this,b)})}})(jQuery);
function loading(val){
if(val == false){
$("#loading").hide();
}
else{
$("#loading").show();
}
}
$(document).ready(function() {
$(document).foundation();
jQuery.ajaxSetup({
'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});
$("select").select2();
$('.hastip').tooltipsy({
offset: [0, 6],
show: function (e, $el) {
$el.css({
'bottom': parseInt($el[0].style.bottom.replace(/[a-z]/g, '')) - 50 + 'px',
'opacity': '0.0',
'display': 'block'
}).animate({
'bottom': parseInt($el[0].style.bottom.replace(/[a-z]/g, '')) + 50 + 'px',
'opacity': '0.9'
}, 300);
},
hide: function (e, $el) {
$el.slideUp(100);
},
css: {
'padding': '10px',
'color': '#fff',
'background-color': '#000',
'border': '1px solid #777',
'-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
'-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
'text-shadow': 'none'
}
});
$(document.body).on("click","#outofstock",function(){
$.ajax({
type: "POST",
url: "/positemsonly",
data: {filter: "outofstock", category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("click","#allinventory",function(){
$.ajax({
type: "POST",
url: "/positemsonly",
data: {filter: "all", category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(".fixed_search").keyup(function(){

alert($(".positemsonly").hasClass("selected"));

if($(".positemsonly").hasClass("selected"))
{
$.ajax({
type: "POST",
url: "/possearch",
data: {query: $(this).val(), poscategory: $("#poscategory").val() , orderby: $("#orderby").val(), poslocation: $("#poslocation").val() },
dataType: 'script'
});
loading();
}


else if ($(".ordering").hasClass("selected"))
{
$.ajax({
type: "POST",
url: "/search",
data: {query: $(this).val()},
dataType: 'script'
});
loading();
}


else{
$.ajax({
type: "POST",
url: "/positemsonly",
data: {query: $(this).val()},
dataType: 'script'
});
loading();
}



});






$(".ordering").click(function(){
$.ajax({
type: "POST",
url: "/index",
data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(".positemsonly").click(function(){
$.ajax({
type: "POST",
url: "/positemsonly",
data: {filter: "all", category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#category",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/category",
data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#manufacturer",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/manufacturer",
data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#subcategory",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/subcategory",
data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#orderby",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: $(this).attr("href"),
data: {orderby: $("#orderby").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#poscategory",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/poscategory",
data: {poscategory: $("#poscategory").val(), orderby: $("#orderby").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("click",".update_image",function(e){
// e.preventDefault();
$(".filter_wrapper").fadeTo("slow", 0.5);
src = $(this).attr("data-src") == "text" ? $("#imgsrc").val() : $(this).attr("data-src");
$.ajax({
type: "POST",
url: "/save_image",
data: {item_id: $(this).attr("data-item-id"), src: src},
dataType: 'script'
});
loading();
});
$(document.body).on("click",".cameraicon",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/cameraicon",
data: {item_id: $(this).attr("data-item-id"),query: $(this).attr("data-title"), item_number: $(this).attr("data-item-number")},
dataType: 'script'
});
loading();
});
$(document.body).on("change","#poslocation",function(){
$(".filter_wrapper").fadeTo("slow", 0.5);
$.ajax({
type: "POST",
url: "/poslocation",
data: {poslocation: $("#poslocation").val(), orderby: $("#orderby").val()},
dataType: 'script'
});
loading();
});
$(document.body).on("click",".pagination a",function(e){
e.preventDefault();
console.log($(this).attr("href"));
$.ajax({
type: "POST",
url: $(this).attr("href"),
dataType: 'script'
});
loading();
});
$(document.body).on("click",".load_sales",function(e){
e.preventDefault();
$.ajax({
type: "POST",
url: $(this).attr("href"),
data: { item_id: $(this).attr("data-item-id") },
dataType: 'script'
});
loading();
});
$(document.body).on("click",".load_items",function(e){
e.preventDefault();
$.ajax({
type: "POST",
url: $(this).attr("href"),
data: { sale_id: $(this).attr("data-sale-id") },
dataType: 'script'
});
loading();
});
$(document.body).on("click",".pos",function(){

$.ajax({
type: "POST",
url: "/posinfo",
data: { product_id: $(this).attr("data-product-id")},
dataType: 'script'
});
loading();


});
$(function() {
$( "#products" ).sortable({
        start: function (event, ui) {
            var currPos1 = ui.item.index();
     
        },
        update:  function (event, ui) {
            var currPos2 = ui.item.index();
            	replaced = ui.item.next().attr("data-wall-id");
            	//alert(ui.item.prev().attr("data-wall-id"));
            	//alert(ui.item.attr("data-wall-id"));
//ui.item.attr("data-wall-id",replaced);
//ui.item.next().attr("data-wall-id",(parseInt(replaced) + 1) ) ;

$.ajax({
type: "POST",
url: "/posorder",
data: { wall_id: ui.item.attr("data-wall-id"), item_id: ui.item.attr("data-item-id"), index: ui.item.index(), replaced: ui.item.next().attr("data-wall-id"), previous: ui.item.prev().attr("data-wall-id") },
dataType: 'script'
});

        }
});
$( "#products" ).disableSelection();
});
});
$(function(){ $(document).foundation(); });