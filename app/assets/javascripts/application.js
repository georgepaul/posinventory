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
$( document ).ready(function() {

$(document).foundation();

jQuery.ajaxSetup({ 
   'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
 });

$("select").select2();

$(".fixed_search").keyup(function(){
	$( "#products" ).fadeTo( "slow" , 0.5);
	$.ajax({
		type: "POST",
		url: "/search",
		data: {query: $(this).val()},
		dataType: 'script'
		});
});


$(document.body).on("change","#category",function(){
	$( "#products" ).fadeTo( "slow" , 0.5);
		$(".filter_wrapper").fadeTo("slow", 0.5);

	$.ajax({
		type: "POST",
		url: "/category",
		data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
		dataType: 'script'
		});
});

$(document.body).on("change","#manufacturer",function(){
	$( "#products" ).fadeTo( "slow" , 0.5);
		$(".filter_wrapper").fadeTo("slow", 0.5);
	
	$.ajax({
		type: "POST",
		url: "/manufacturer",
		data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
		dataType: 'script'
		});
});

$(document.body).on("change","#subcategory",function(){
	$( "#products" ).fadeTo( "slow" , 0.5);
    $(".filter_wrapper").fadeTo("slow", 0.5);

	$.ajax({
		type: "POST",
		url: "/subcategory",
		data: {category: $("#category").val(), subcategory: $("#subcategory").val(), manufacturer: $("#manufacturer").val()},
		dataType: 'script'
		});
});

$(document.body).on("click",".pos",function(){
	$( "#products" ).fadeTo( "slow" , 0.5);
    $(".filter_wrapper").fadeTo("slow", 0.5);

	$.ajax({
		type: "POST",
		url: "/posinfo",
		data: { product_id: $(this).attr("data-product-id")},
		dataType: 'script'
		});
});

});
$(function(){ $(document).foundation(); });
