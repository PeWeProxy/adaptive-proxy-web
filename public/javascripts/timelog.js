timelog = function($) {

  period = 4

  active_in_last_period = true;

  // This is required to get around XSS restrictions in browsers
  // when HTML base tag changes the relative URLs
  var base = window.location.host

  $(document).ready(function() {
      $('body').mousemove(function () {
        active_in_last_period = true;
      });
      $(window).scroll(function() {
        active_in_last_period = true;
      });
  });

  upload_activity = function() {
    if (active_in_last_period) {
      $.post('http://' + base + '/activity/update', { 'checksum': _ap_checksum, 'period': period, 'nologging': 'true' });
      active_in_last_period = false;
    }
  }

  setInterval(upload_activity, period * 1000)

}(jQuery);
