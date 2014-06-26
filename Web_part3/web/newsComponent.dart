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


class News {
  String title;
  String content;
  String author;
  DateTime date;
  String img;

  News({this.title, this.content, this.author, this.date, this.img});

  News.fromJSON(var json) {
    this.title = json["title"];
    this.content = json["content"];
    this.author = json["author"];
    this.img = json["img"];
    this.date = new DateTime.fromMillisecondsSinceEpoch(json["date"]);
  }

  String toString() {
    return "[News: title='${this.title}', content='${this.content.substring(0, 20)}', author='${this.author}', img='${this.img}']";
  }

  Map toJSON() {
    return {"title": "${this.title}", "content": "${this.author}", "author": "${this.author}", "date": 0, "img": "${this.img}"};
  }
}

@Controller(
    selector: "[news-add]",
    publishAs: 'ctrl'
) class NewsAddForm {

  News news = new News();

  NewsAddForm() {

  }

  void sendNews() {
      // Sending
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

  }

  void fetchNewsFrom(String url) {
    HttpRequest.getString(url).then((String value) {
      var data = JSON.decode(value);
      for (var newsJsonData in data) {
        NewsList.listNews.add(new News.fromJSON(newsJsonData));
      }
    });
  }

  List<News> get listOfNews => NewsList.listNews;
}
