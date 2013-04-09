

!function ($) {

  $(function(){



    // fix sub nav on scroll
    var $win = $(window)
      , $nav = $('.subnav')
	  , navHeight = $('.navbar').first().height()
      , navTop = $('.subnav').length && $('.subnav').offset().top - navHeight
      , isFixed = 0

    processScroll()

    $win.on('scroll', processScroll)

    function processScroll() {
      var i, scrollTop = $win.scrollTop()
      if (scrollTop >= navTop && !isFixed) {
        isFixed = 1
        $nav.addClass('subnav-fixed')
      } else if (scrollTop <= navTop && isFixed) {
        isFixed = 0
        $nav.removeClass('subnav-fixed')
      }
    }

	
	
	$('a[rel=tooltip]').tooltip();
    //$('.popover-test').popover();

    // popover on rel=popover
    $("a[rel=popover]")
      .popover( {title: 'Properties'} )
      .click(function(e) {
        e.preventDefault()
      })

 	
 	$('a[data-toggle="tab"]').on('shown', function (e) {
  		e.target // activated tab
  		e.relatedTarget // previous tab
		});


	
 	$(".alert").alert(); 
 	
 	$('.datepicker').datepicker();	

	
	$(".carousel").carousel({interval: 8000});



})

}(window.jQuery)