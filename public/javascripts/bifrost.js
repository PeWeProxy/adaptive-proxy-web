bifrost = function(jQuery) {

  if(jQuery) var $ = jQuery

  // This is required to get around XSS restrictions in browsers
  // when HTML base tag changes the relative URLs
  var base = window.location.host;

  var oldLocation = location.href;
  setInterval(function() {
    if(location.href != oldLocation) {
      loadResults()
      oldLocation = location.href
    }
  }, 500);

  function loadResults() {
    if(window.location.href.indexOf("dontrecommend") != -1) return;

    match = /[?&]q=(.*?)($|&.*)/.exec(window.location.href)
    query = match[1]

    $.get('http://' + base + '/bifrost/search', {'v': '1.0', 'q': query}, function(data) {
        $("#res ol li:first").prepend(data);
    });
  }

  $(document).ready(function() {
      loadResults();
  });

  bifrost = new Object();

  bifrost.negativeFeedback = function(recommendationId, groupId, query) {
    $(".recommendation-" + recommendationId).hide()
    $.get('http://' + base + '/bifrost/negativefeedback', {'id': groupId, 'q': query})
  }

  bifrost.negativeGroupFeedback = function(recommendationGroupId, groupId, query) {
    $(".recommendation-group-title-" + recommendationGroupId).hide()
    $(".recommendation-group-" + recommendationGroupId).hide()
    $.get('http://' + base + '/bifrost/negativefeedback', {'id': groupId, 'q': query})
  }
  return bifrost;
}(adaptiveProxyJQuery);
