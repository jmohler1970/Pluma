/*
 * Adapted from GetSimple js file	
 */

jQuery(document).ready(function() { 

	// pages
  $("#show-characters").live("click", function() {
  	 $(".showstatus").toggle();
  	 $(this).toggleClass('current');
  });

	
	$("#post-menu-enable").live("click", function() {
    	$("#menu-items").slideToggle("fast");
		});
  	if ($("#post-menu-enable").is(":checked")) { 
  		} else {
     		$("#menu-items").css("display","none");
  		}
  		
  	//pages.edit	
  	function updateMetaDescriptionCounter() {
	  var remaining = 155 - jQuery('#post-metad').val().length;
	  jQuery('#countdown').text(remaining);
	  Debugger.log('Meta Description has '+remaining+' characters remaining');
	}
	if ($('#post-metad').length) {
		updateMetaDescriptionCounter();
	  $('#post-metad').change(updateMetaDescriptionCounter);
	  $('#post-metad').keyup(updateMetaDescriptionCounter);
	}	

	
  var edit_line = $('#submit_line span').html();
  $('#js_submit_line').html(edit_line);
  $("#js_submit_line button").live("click", function() {
   
   
    $("#submit_line button").trigger('click');
	});


	//title filtering on pages, backups, & users
	var filterSearchInput = $("#filter-search");
	$('#filtertable').live("click", function($e) {
		$e.preventDefault();
		filterSearchInput.slideToggle();
		$(this).toggleClass('current');
		filterSearchInput.find('#q').focus();
	});
	$("#filter-search #q").keydown(function($e){
		if($e.keyCode == 13) {
			$e.preventDefault();
		}
	});
	$("#editpages tr:has(td.pagetitle)").each(function(){
   var t = $(this).find('td.pagetitle').text().toLowerCase();
   $("<td class='indexColumn'></td>").hide().text(t).appendTo(this);
 	});
	$("#filter-search #q").keyup(function(){
		var s = $(this).val().toLowerCase().split(" ");
		$("#editpages tr:hidden").show();
		$.each(s, function(){
    	$("#editpages tr:visible .indexColumn:not(:contains('" + this + "'))").parent().hide();
 		});
	});
	$("#filter-search .cancel").live("click", function($e) {
		$e.preventDefault();
		$("#editpages tr").show();
		$('#filtertable').toggleClass('current');
		filterSearchInput.find('#q').val('');
		filterSearchInput.slideUp();
	});


	//create new folder in pages
	var newFolderDiv = $("#new-folder");
	$('#createfolder').live("click", function($e) {
		$e.preventDefault();
		newFolderDiv.find("form").show();
		$(this).hide();
		newFolderDiv.find('#foldername').focus();
	});
	$("#new-folder .cancel").live("click", function($e) {
		$e.preventDefault();
		newFolderDiv.find("#foldername").val('');
		newFolderDiv.find("form").hide();
		$('#createfolder').show();
	});
	
	
	$("#metadata_toggle").live("click", function($e) {
		$e.preventDefault();
		$("#metadata_window").slideToggle('fast');
		$("#link_window").slideToggle('fast');
		$(this).toggleClass('current');
	});
	
	
	$("#components_toggle").live("click", function($e) {
		$e.preventDefault();
		$("#components_window").slideToggle('fast');
		$(this).toggleClass('current');
	});	


    $( "#startDate" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 2,
        onClose: function( selectedDate ) {
            $( "#startDate" ).datepicker( "option", "minDate", selectedDate );
        }
    });
    
    $( "#endDate" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 2,
        onClose: function( selectedDate ) {
            $( "#endDate" ).datepicker( "option", "maxDate", selectedDate );
        }
    });
    
    
    $(".delconfirm").live("click", function() {
		var message = $(this).attr("title");
		var dlink = $(this).attr("href");
		var mytr=$(this).parents("tr");
		mytr.css("font-style", "italic");
	    var answer = confirm(message);
	    if (answer)	{	
	    	return true;
	    	}
	    else
	    	{
	    	mytr.css('font-style', 'normal');
	    	return false;
	    	}
	});
    
    
	
//end of javascript for getsimple
}); 
