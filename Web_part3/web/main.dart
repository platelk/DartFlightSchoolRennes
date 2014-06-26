library main;

import 'dart:js';
import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:animation/animation.dart' as anim;

part 'Swipe.dart';
part 'WearAppAngular.dart';
part 'newsComponent.dart';
part 'utils.dart';

class Wear {
  JsObject _androidWear;

  Wear() {
    this._androidWear = context["AndroidWear"];
  }

  void sendNotification(String title, String text) {
    print("Send notif");
    if (_androidWear != null)
      _androidWear.callMethod("sendNotification", [title, text]);
  }
}

void setSwipeLeftSidePanel() {
  bool isSwipe = false;
  var button = querySelector("main");
  SwipeEvent s = new SwipeEvent(button);
  s.onSwipeEvent.listen((SwipeEvent event) {
    Element e = querySelector('.menu');
    if (event.swipeValue == SwipeEvent.SWIPE_LEFT && isSwipe == true) {

      e.click();
      isSwipe = false;
    }
    if (event.swipeValue == SwipeEvent.SWIPE_RIGHT && isSwipe == false) {
      e.click();
      isSwipe = true;
    }
  });
}

void main() {
  //setSwipeLeftSidePanel();
  initAngular();
  Wear wear = new Wear();

  querySelector("#send-news-button").onClick.listen((MouseEvent e) {
    print("click");
      String title = querySelector("#news-title").nodeValue;
      String author = querySelector("#news-author").nodeValue;
      String content = querySelector("#news-content").nodeValue;
      HttpRequest.postFormData('addNews', {"data": JSON.encode({"title" :title, "content": content, "author": author, "date": 0, "img": "img"})});
  });
  //var a = new Timer.periodic(new Duration(seconds: 5), (e) => wear.sendNotification("My notif", "This is a notification test by timer callback"));
  //button.onClick.listen((e) => wear.sendNotification("My notif", "This is a notification test"));
}