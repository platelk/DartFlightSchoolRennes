part of main;

List<String> getAllCssLink() {
  ElementList l = querySelectorAll("link");
  List<String> cssLink = [];
  for (Element i in l) {
    if (i.attributes["href"].contains(".css")) {
      cssLink.add(i.attributes["href"]);
    }
  }
  return cssLink;
}

List<Element> getAllCss() {
  ElementList l = querySelectorAll("link");
  List<String> cssLink = [];
  for (Element i in l) {
    if (i.attributes["href"].contains(".css")) {
      cssLink.add(i);
    }
  }
  return cssLink;
}