kw = function($) {

  // This is required to get around XSS restrictions in browsers
  // when HTML base tag changes the relative URLs
  var base = window.location.host;

  var retries = 0;

  function fetchKeywords() {
    jQuery.get('http://' + base + '/keywords/load', {'checksum': _ap_checksum}, function(data) {
      if(!/^\s*$/.test(data)) {
        clearTimeout(timer);
        jQuery('#_ap_messagebox').html(data);
      }

      retries++;

      if(retries > 3) {
        clearTimeout(timer)
      }
    });
  }

  $(window).scroll(function() {
    $('#_ap_messagebox').css('top', $(window).scrollTop()+"px");
  });

  $(document).ready(function() {

    $('#_ap_messagebox').click(function() {
      $(this).hide();
    });

    setTimeout(fetchKeywords, 1000);
    timer = setInterval(fetchKeywords, 5000);
  });

}(jQuery);
