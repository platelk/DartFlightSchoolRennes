part of main;

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