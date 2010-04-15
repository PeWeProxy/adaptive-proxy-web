function FindProxyForURL(url,host) {

  var PROXY = "PROXY peweproxy.fiit.stuba.sk:9666; DIRECT"

 if(shExpMatch(url, "ftp://*")) {
   return "DIRECT";
 }

  if(shExpMatch(url, "*activity/update*")) {
    return PROXY;
  }

  if ((host == "localhost") ||
      (shExpMatch(host, "localhost.*")) ||
      (host == "127.0.0.1")) {
        return "DIRECT";
  }

  if (shExpMatch(host,"*.ynet.sk")) {
    return "DIRECT";
  }

  if (shExpMatch(url, "*.css") ||
      shExpMatch(url, "*.css?*") ||
      shExpMatch(url, "*.js") ||
      shExpMatch(url, "*.js?*") ||
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
      shExpMatch(url, "*.jar") ||
      shExpMatch(url, "*.class") ||
      shExpMatch(url, "*.xap") ||
      shExpMatch(url, "*.svc") ||
      shExpMatch(url, "*.svg") ||
      shExpMatch(url, "*.svg?*") ||
      shExpMatch(url, "*.zip") ||
      shExpMatch(url, "*.pdf") ||
      shExpMatch(url, "*.doc") ||
      shExpMatch(url, "*.ppt") ||
      shExpMatch(url, "*.xls") ||
      shExpMatch(url, "*.exe")) {
    return "DIRECT";
  }

  if (shExpMatch(url,"https://*")) {
    return "DIRECT";
  }

  return PROXY;
}
