part of main;

class WearAppAngular extends Module {
  WearAppAngular() {
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
    views.configure({
        'news': ngRoute(
            defaultRoute: true,
            path: "/news",
            view: 'news_page.html'
        ),
        'about': ngRoute(
          path: "/about",
          view: 'about_page.html'
        ),
        'addNews': ngRoute(
          path: "/addNews",
          view: 'add_news.html',
          enter: (h) {

          }
        )
    });
  }
}

void initAngular() {
  applicationFactory()
  .addModule(new WearAppAngular())
  .run();
}