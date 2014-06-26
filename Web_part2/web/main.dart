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
part 'news.dart';
part 'newsComponent.dart';
part 'NewsAppAngular.dart';
part 'utils.dart';


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
}