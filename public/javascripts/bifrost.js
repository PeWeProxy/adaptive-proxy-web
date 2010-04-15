kw = function($) {

  // This is required to get around XSS restrictions in browsers
  // when HTML base tag changes the relative URLs
  var base = window.location.host;

  var retries = 0;

  function loadResults() {
    match = /[?&]q=(.*?)($|&.*)/.exec(window.location.href)
    query = match[1]

    $.get('http://' + base + '/bifrost/search', {'v': '1.0', 'q': query}, function(data) {
        $("#res ol li:first").prepend(data);
    });
  }

  $(document).ready(function() {
      loadResults();
  });

}(adaptiveProxyJQuery);
