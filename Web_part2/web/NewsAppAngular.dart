part of main;

class NewsAppAngular extends Module {
  NewsAppAngular() {
    type(NewsList);
    type(NewsFilter);
    type(NewsAddForm);
    value(RouteInitializerFn, this.definePageRoute);
    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));
  }

  void onClick() {
    print("click");
  }

  void definePageRoute(Router router, RouteViewFactory views) {
  }
}

void initAngular() {
  applicationFactory()
  .addModule(new NewsAppAngular())
  .run();
}
