function FindProxyForURL(url,host) {

  var PROXY = "PROXY nimbus.fiit.stuba.sk:9666; DIRECT"

 if(shExpMatch(url, "ftp://*")) {
   return "DIRECT";
 }

  if(shExpMatch(url, "*activity/update*")) {
    return PROXY;
  }

/*
  if ((host == "localhost") ||
      (shExpMatch(host, "localhost.*")) ||
      (host == "127.0.0.1")) {
        return "DIRECT";
  }
*/

  if (shExpMatch(url, "*.css") ||
      shExpMatch(url, "*.css?*") ||
  //    shExpMatch(url, "*.js") ||
  //    shExpMatch(url, "*.js?*") ||
      shExpMatch(url, "*.jpg") ||
      shExpMatch(url, "*.jpg?*") ||
      shExpMatch(url, "*.jpeg") ||
      shExpMatch(url, "*.jpeg?*") ||
      shExpMatch(url, "*.gif") ||
      shExpMatch(url, "*.gif?*") ||
      shExpMatch(url, "*.png") ||
      shExpMatch(url, "*.png?*") ||
      shExpMatch(url, "*.ico") ||
      shExpMatch(url, "*.ico?*") ||
      shExpMatch(url, "*.swf") ||
      shExpMatch(url, "*.swf?*") ||
      shExpMatch(url, "*.svg") ||
      shExpMatch(url, "*.svg?*")) {
    return "DIRECT";
  }

  if (shExpMatch(url,"https://*")) {
    return "DIRECT";
  }

  return PROXY;
}
