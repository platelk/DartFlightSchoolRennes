part of main;

class SwipeEvent {
  double cos;
  double angle;
  double min_dist = 10.0;
  double transX;
  double transY;
  static final int SWIPE_UP = 90;
  static final int SWIPE_DOWN = 270;
  static final int SWIPE_LEFT = 0;
  static final int SWIPE_RIGHT = 180;
  static final List<int> _possibleSwipe = [SWIPE_UP, SWIPE_DOWN, SWIPE_LEFT, SWIPE_RIGHT];
  int swipeValue = -1;
  Element e;
  StreamController<SwipeEvent> _stream;

  SwipeEvent(this.e) {
    _stream = new StreamController.broadcast();
    this._listen();
    print(this);
  }

  void _listen() {
    Point start = null;
    Point end = null;
    e.onTouchStart.listen((mEvent) {
      mEvent.preventDefault();
      if (mEvent.touches.length > 0) {
        start = mEvent.touches[0].page;
      }
    });
    e.onTouchMove.listen((TouchEvent mEvent) {
      mEvent.preventDefault();
      if (mEvent.touches.length > 0 && start != null) {
        end = mEvent.touches[0].page;
      }
    });
    e.onTouchEnd.listen((TouchEvent mEvent) {
      mEvent.preventDefault();
      if (_hasSwipe(start, end)) {
        this._stream.add(this);
        start = null;
      }
    });
    e.onMouseDown.listen((mEvent) {
          start = mEvent.client;
      });
      e.onMouseUp.listen((mEvent) {
        end = mEvent.client;
        if (_hasSwipe(start, end)) {
          this._stream.add(this);
        }
      });
  }

  void _calcSwipe(Point start, Point end) {
    transX = start.x - end.x;
    transY = start.y - end.y;
    int vecRefX = 20;
    int vecRefY = 0;

    double cos = ((transX * vecRefX) + (vecRefY * transY)) / (sqrt((pow(transX, 2) + pow(transY, 2)) * (pow(vecRefX, 2) + pow(vecRefY, 2))));
    this.angle = (acos(cos) / PI) * 180;
    this.cos = cos;
  }

  bool _hasSwipe(Point start, Point end) {
    _calcSwipe(start, end);
    if (transX.abs() < this.min_dist && transY.abs() < min_dist) {
      return false;
    }
    for (int SWIPE in _possibleSwipe) {
      if ((angle >= SWIPE - 20) && (angle <= SWIPE + 20)) {
        if (SWIPE == SWIPE_UP && transY < 0) {
          SWIPE = SWIPE_DOWN;
        }
        swipeValue = SWIPE;
        return true;
      }
    }
    return false;
  }

  String toString() {
    return "transX: ${transX}, transY: ${transY}, cos: ${cos}, angle: ${angle}";
  }

   Stream get onSwipeEvent {
     return _stream.stream;
   }
}
