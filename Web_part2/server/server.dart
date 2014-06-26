import 'package:cameleon/cameleon.dart';

class NewsApp {
  static const String HTML_DIR = "../web/";

  // Crée une route disponible pour http://127.0.0.1:4545/
  @Route("/")
  dynamic homePage() {
    return Route.file(HTML_DIR + "index.html");
  }

  // Crée une route disponible pour http://127.0.0.1:4545/getNews
  @Route("getNews")
  String getNews() {

  }

  // Crée une route disponible pour http://127.0.0.1:4545/addNews, en POST et récupère les données les données reçu
  @Route("addNews", method: Method.POST, others_param: const [HttpParams.PostData])
  String addNews(Map<String, String> post_data) {

  }
}

void main() {
  Cameleon server = new Cameleon(4545); // 4545 est le port d'écoute du serveur

  server.addRouteDir("/", NewsApp.HTML_DIR); // Rend disponible tous les fichiers et sous dossiers présent dans WearApp.HTML_DIR
  server.addRoute(new NewsApp()); // Ajoute les routes présent dans la classe NewsApp
  server.run(); // lance le serveur
}