  feedback_sent = false;
  
  // This is required to get around XSS restrictions in browsers
  // when HTML base tag changes the relative URLs
  var base = window.location.host

  function wiSendFeedback(value){  
  	if (!feedback_sent) {
  		$.post('http://' + base + '/webimp/feedback?nologging', {
			'checksum': _ap_checksum,
  			'value': value,
  			'nologging': 'true'
  		});
  		feedback_sent = true;
  	}
  }(adaptiveProxyJQuery);
