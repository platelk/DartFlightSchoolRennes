part of main;

@Formatter(name: "newsFilter")
class NewsFilter {
  List<News> call(List<News> newsList, String filter) {
    List<News> news_to_display = [];
    if (filter.length == 0)
       return newsList.reversed;
    for (News n in newsList) {
       if (n.title.contains(filter)) {
         news_to_display.add(n);
       }
    }
    news_to_display = news_to_display.reversed;
    return news_to_display;
  }
}

@Controller(
  selector: "[news-list]",
  publishAs: 'ctrl'
) class NewsList {
  String newsFilter = "";
  static List<News> listNews = [];

  NewsList() {
    if (listOfNews.length == 0) {
      this.fetchNewsFrom("getNews");
    }

    /*new Timer.periodic(new Duration(seconds: 30), (e) {
      this.fetchNewsFrom("getNews");
    });*/
  }

  void fetchNewsFrom(String url) {
    // Récupérer les news
  }

  List<News> get listOfNews => NewsList.listNews;
}
