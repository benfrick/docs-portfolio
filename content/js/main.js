// expand/collapse sidebar section and highlight sidebar on click
jQuery(function() {
    var $child;
	var $sidebar = $('#sidebar');
	//need this to highlight sidebar links at bottom of page
    //highlight sidebar h2 on click event
	$sidebar.find('a').click(function() {
		$sidebar.find('a').removeClass('active');
		$(this).addClass('active');
		console.log('added active class to '+$(this).attr('name'));
	});
    //collapse/expand sidebar section on click event
    //collapse all others
	$sidebar.find('span.toggle').click(function() {
	    var clickedsection = $(this).attr('name'); //h6 name
	    var $clickedchild = $('#'+clickedsection); //ul id same as h6 name
	    var $sections = $sidebar.find('.show');
        if ($clickedchild.hasClass('hide')) {
	       $clickedchild.removeClass('hide');
	       $clickedchild.addClass('show');
	    } else {
	        $clickedchild.removeClass('show');
	        $clickedchild.addClass('hide');
	    }
	    $sections.each(function() {
	        $child = $('#'+$(this).attr('id'));
	        if ($child.hasClass('show') && ($clickedchild.attr('id') != $child.attr('id'))) {
	            $child.removeClass('show');
            	$child.addClass('hide');
	        }
	    });
	});
});

// highlight the sidebar link when you scroll to another section
$( document ).ready(function() {
    // cache sidebar links
    var $navigationLinks = $('#sidebar > section > ul > li > ul > li > a');
    // cache sections in reverse order
    var $sections = $($('div.main h2').get().reverse());

    // map section ids to sidebar links
    var sectionIdTonavigationLink = {};
    $sections.each(function() {
        var id = $(this).attr('id');
        sectionIdTonavigationLink[id] = $("#sidebar a[href$='#" + id + "']");
    });

    function highlightClosestHeader() {
        // get the position of the vertical scroll bar
        var scrollPosition = window.scrollY;

        // iterate through the sections
        $sections.each(function() {
            var currentSection = $(this);
            // get the top position of the section
            var sectionTop = currentSection.offset().top;

            // highlight the sidebar link if the user has scrolled over the top of the section
           if (scrollPosition >= sectionTop - 100) {
                // get the section id
                var id = currentSection.attr('id');
                // get the sidebar link
                var $link = sectionIdTonavigationLink[id];

                if ($link && !$link.hasClass('active')) {
                    // remove .active class from all sidebar links
                    $navigationLinks.removeClass('active');
                    // add .active class to the current sidebar link
                    $link.addClass('active');
                }
                return false;
            }
        });
     }

    $(window).on("scroll", function(evt) {
        highlightClosestHeader();
    });
});
