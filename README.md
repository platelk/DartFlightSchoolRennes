# Dart Flight School Rennes

##1. Présentation

### Dart c'est quoi ?

Dart est un langage de programmation pensé pour construire de grandes applications web tel que Gmail, Twitter, ... en étant présent sur les deux aspects du web : le client et le serveur.

#### Quel est le but du TP ?

Durant ce TP, vous serez ammenés à réaliser un petit système de news, avec d'un coté un serveur permettant de fournir les ressources et les news et de l'autre, une page web pour afficher sans actualisation les news et en créer de nouvelles.

#### Aide et support

Pour vous aider durant ce TP, le site officiel [Dartlang](https://www.dartlang.org/docs/dart-up-and-running/contents/) sera votre meilleur allié, et plus particulièrement la section [Dart Chapter Tour](https://www.dartlang.org/docs/dart-up-and-running/contents/)

#### Ressources et outils
Les ressources du tp sont disponibles sur [github/platelk](https://github.com/platelk)

Pensez à télécharger le [SDK Dart](https://www.dartlang.org/), qui comprend Dartium et le DartEditor.
Pour ceux qui n'aiment pas trop les IDE basés sur Eclipse, [WebStorm](http://www.jetbrains.com/webstorm/) est disponible et compatible avec Dart.

#2. Travaux Pratiques

## 1ere partie : Créer notre premier projet
Le commencement de toute chose est de créer un nouveau projet. Pour ça faites **File > Open existing Folder ** et sélectionner le Dossier ___ News_part1 ___

### - Un projet Dart
Comme vous pouvez le voir, plusieurs dossiers et fichiers sont présents, faisons un peu le tour :

-  ###/
 * ####packages
 > Contient les dépendences de votre projet (les libs)
 * ####web 
 > Contient tous vos fichier de développement
    
    * #####fonts/
    * #####images/
    * #####scripts/
    * #####styles/
    * #####main.dart
    > Point d'entrée de votre programme
    * #####index.html
    > Votre page web (votre vu si vous préférez)
 * ####pubspec.yaml
 > Fichier de configuration de votre application qui vous permettera de gérer vos dépendences.

Maintenant que l'on a vu ce que contenait notre dossier, intéréssons nous au fichier **main.dart**

```dart
library main; // Definit notre projet comme un lib contenant les fichiers de notre projet

import 'dart:js'; // Importe / Inclut le package dart:js dans notre projet
import 'dart:html'; // Idem pour dart:html

void main() {
    /* Corps de notre projet */ 
}
```

Bon, comme vous le voyez, la syntaxe est pour l'instant très proche de langages populaires comme le C++ / C# ou Java, et c'est parfaitement normal car l'équipe en charge de la création de dart a créé ce langage dans le but qu'il soit facile a apprendre pour les développeurs venant d'autres langages.

Regardons maintenant un autre fichier important de notre projet **pubspec.yaml**
```yaml
name: News # Nom de notre application
version: 0.0.1 
dependencies:
  angular: '>=0.12.0' # Ici on dit 'Je veux utiliser le package angular avec une version supérieur à 0.12'
  animation:
    git: git://github.com/platelk/Animation.git # Je ne veux pas le package les dépots pub mais celui sur un git
  browser: '>= 0.10.0'
```

Ce fichier est très important dans un projet. C'est lui qui va préciser quels packages sont utilisés par notre application, son nom, sa version, ... on peut préciser plein de choses comme les auteurs ou le site du projet.
Par défaut quand vous écrivez `angular: '>=0.12.0'`, l'utilitaire ***pub*** va aller sur les [packages pub](http://pub.dartlang.org/). Ce site web référence tous les packages proposés par la communauté, comme le [package angular](http://pub.dartlang.org/packages/angular). la page d'un package comprend au moins les sections **installing** et __version__. Dans la section **installing** vous pouvez voir quelle ligne rajouter pour que ce package soit disponible dans votre projet ;).

### C'est l'heure du R-R-R-R-Run !
Ok vous avez un projet, mais ce serait sympa de le lancer non ? pour ca c'est très simple. Sur DartEditor il suffit d'appuyer sur le boutton vert de run, ou clic droit sur votre fichier dart, puis run

### Un peu de logique

Maintenant que vous avez votre projet Dart, il faut commencer à le rendre un peu intéressant, car juste avoir un page statique c'est pas très sexy.

Pour ca on va rajouter un peu de code Dart dans notre fonction `main`. Notre premier but sera de transformer le mot donnée dans le champ texte par `Dart is awesome !`

Pour vous aidez à faire ça je vais vous donnez 2 indications :

####1. Un selecteur pour les selectionner tous !
En Dart, il existe une fonction contenue dans le package `dart:html` qui se nomme `querySelector("Css selector")` cette fonction retourne un object (le premier si plusieurs correspondent à la recherche) demandé grâce au selecteur CSS.
> pour ceux ne connaissant pas les selecteurs CSS, voici un petit site : [W3CSchool : CSS selector](http://www.w3schools.com/CSSref/css_selectors.asp)

####2. Retour vers le Future<T> !
En Dart (qui permet la programmation asynchrone), il existe un concept appelé `Future<T>`. Les Futures sont des objects qui contiennent la valeur de retour d'une fonction et appelle la fonction demande SEULEMENT quand la valeur est disponible.
petit exemple :

> J'ai un boutton et je veux appeler la fonction associée au bouton SEULEMENT quand un utilisateur a appuyé sur le bouton. pour faire ça en dart:

```dart
import 'dart:html'

void onButtonClick(MouseEvent e) {
    print("Button click");
}

void main() {
    /* j'appel le getter onClick, qui est un future donc je dis que j'appele ma fonction onButtonClick seulement lors de l'event Click */
    querySelector("button").onClick.then(onButtonClick);
}
```

Voila, je vous ai donné les outils primordiaux pour réaliser cette étape.

*** Note: Pour ca, vous aurez peut-être besoin de plus de chose que ce que j'ai expliqué, si vous pensez que c'est le cas, google est votre ami :) ***

### Vers l'infini et l'Angular !

Maintenant que vous avez manipulé Dart, sans aucune surcouche, nous allons nous intérésser à une bibliothèque très populaire actuellement nommé [Angular](https://angulardart.org/). Cette bibliothèque permet d'apporter du dynamisme et de la structure aux pages web dans le but de créer de plus grosses applications web. Angular apporte plusieurs concepts très bien expliqués sur leur [site officiel](https://angulardart.org/demo/). faites un petit tour dessus avant d'attaquer la suite du TP.

Vous êtes allés voir ? non ?! allez-y !

C'est bon ? on va dire que je vais vous croire.

Notre premier but sera d'afficher dynamiquement les news sur le flux de news. Pour faire cela, la première chose que l'on va faire c'est créer une classe représentant une news.

D'abord créons un nouveau fichier dart nommé `news.dart` dans le dossier `web/`. La première chose à faire pour dire à votre application dart qu'elle a besoin du fichier `news.dart`, c'est de rajouter :

***main.dart***
```dart
part 'news.dart'
```

***news.dart***
```dart
part of main /* pourquoi 'main' ? car c'est le nom donné après la directive 'library main' dans votre fichier main.dart */
```

> #####___Note:___ *Ici on utilise 'part', car on considère que news.dart est un fichier utilisé par notre projet et que cela ne sert à rien de l'exporter car trop spécifique a notre problème. Si nous voulions préciser que ce fichier contient des choses plus génériques, on utiliserait la directive `import`*

Bon une news c'est composé de quoi ? un titre, un auteur, un contenu, une date et un lien vers la news complète.
Cela a l'air d'être un bon début. maintenant, une class en dart :

```dart

// Convention de nommage : les noms de classes commencent par une Maj
class MyClass {
    String myAttr; // Mon attribut
    News(String myAttr) {
        this.myAttr = myAttr;
    }
}
```


Ah non attendez, c'est chiant d'écrire 2 fois l'attribut myAttr juste pour initializer mon attribut. c'est mieux comme ça :

```dart

// Convention de nommage : les noms de classes commencent par une Maj
class MyClass {
    String myAttr; // Mon attribut
    News(this.myAttr); // et ça fait la même chose :p
}
```

 * Donc maintenant que vous savez faire une classe, Créez une classe representant une news.
    > Il est possible de faire des fonctions avec des paramètres nommés, comme ceci :

```dart
void my_func({int param1, int param2}) {
    // ...
}

my_func(param1: 24, param2: 42);
```
...

* Maintenant que l'on a une news, on va créer une classe pour notre flux de news,`NewsList` , comprenant comme attribut `List<News> listOfNews`, ne vous inquiétez pas de où vous déclarez votre classe par rapport à news, Dart se débrouillera :), mais par contre pensez à initialiser votre liste dans le constructeur.

* Après ça, rajoutez des news dans la liste de news dans le constructeur de votre classe, de cette manière :
```dart
listOfNews.add(new News(/* Vos paramètre*/));
```
* Rajouter deux import de angular dans votre `main.dart` :

```dart
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
```


Ok, maintenant que l'on a mis la plupart des choses en place, on va passer à un concept de Angular, [Les Controllers !](https://angulardart.org/tutorial/04-ch02-controller.html)

Les controllers sont des entités qui définisse un 'scope' dans un HTML. Grâce à cela on pourra utiliser des variables du controller dans notre html, appeler des fonctions, etc. Je vous conseille vraiment de lire la documentation officiel pour mieux comprendre les concepts.

Donc on va transformer notre classe `NewsList`en controller Angular. pour ça on va rajouter ce que l'on appelle une annotation, qui va être utilisée par Angular.

Juste comme ceci : 
***news.dart***
```dart
@Controller(/* Paramètre à regarder dans la doc ;) */)
class NewsList {
    List<News> listOfNews;
    // corps de la classe
}
```

C'est sympa d'avoir un controller, mais actuellement il ne sert pas à grand chose car nous n'avons pas initialisé Angular.
Allons dans notre fonction `main()` pour lancer angular : 
```dart
void main() {
    applicationFactory()
        .addModule(new Module()..type(NewsList)) 
        .run();
    /* Amusant la syntaxe ..method() non ? cela veux dire Applique la methode '.type()' sur la nouvelle instance de module, et retourne le module et pas le retour de `.type()` */
}
```

ici nous initialisons AngularDart, ajoutons un module qui contiendra notre Controller, puis nous lançons Angular :)

* Rajoutez votre controller dans votre ***web/index.html*** de cette manière :

```html
    <div class="featured-section news-feed" news-list> <!-- Mettez le nom de votre controller-->
        <p>{{ ctrl.listOfNews.length }}</p>
```

et voila, vous avez le nombre de news que vous avez affiché dynamiquement, en fonction du nombre de news donc votre list :), cool non ? enfin faudrait aller un peu plus loin quand meme ^^.

Ce serait bien du coup d'afficher toute nos news directement, faire un `while` dans html. Et Bien c'est possible ! grâce à `ng-repeat`

voila comment rendre cela encore plus intéressant, remplacer le contenu de la balise `<ul>` par :

```html
<ul class="featured-list" ng-repeat="news in ctrl.listOfNews">
            <li class="featured-list__item clear news-component">
                <div class="container-small">
                    <div class="featured-list__content g--half">
                        <h4>{{news.title}}</h4>
                        <p>{{news.content}}</p>
                        <a href="#" class="cta--primary">link</a>
                    </div>
                    <div class="featured-list__img-wrapper g--half g--last">
                        <div class="featured-list__img">
                            <img ng-src={{news.img}} alt="image exemple">
                        </div>
                    </div>
                </div>
            </li>
        </ul>
```

Ah ! C'est mieux là non ? ;)

### Filtrez les tous !

Maintenant on va crée un filtre pour connecter nôtre champs texte de recherche à la liste de news afin de permettre une recherche dynamique dans cette liste. Pour ça, le site officiel de AngularDart est le meilleur endroit, donc allez voir sur le site officiel: [AngularDart: Filter-Service](https://angulardart.org/tutorial/07-ch05-filter-service.html)

> Astuce: Google est vraiment votre amis :)

## (Insérer une blague: serveur)

### Configuration
Maintenant que l'on a fait un peu la partie client, intéréssont nous au serveur. Dart a été créé également pour réaliser des applications qui vont tourner dans le cloud, ou tous simplement sur un serveur. Pour cela, c'est très simple :
* Ouvrer un nouveau projet avec le dossier `Web_part2`

OU si vous voulez garder votre travail :

* Crée un dossier  `server/` à la racine de votre projet
* Récuperez le fichier `server/server.dart` du dossier `Web_part2`
* Ajouter dans le fichier `pubspec.yaml` les lignes suivantes :

```yaml
dependencies:
    cameleon:
        git: git://github.com/platelk/cameleon.dart.git
```

Comme vous pouvez le voir, vous aller utiliser une lib que j'ai réalisé afin de simplifier la création d'application serveur basé sur HTTP. la doc est disponible ici : [Cameleon.dart](http://www.dartdocs.org/documentation/cameleon/0.3.3/index.html#cameleon). 
J'ai fait ce choix pour vous éviter de ré-implémenter certaine chose un peu longue comme les données POST. je vous invite comme même à regarder une mini implémentation pure dart d'un mini-serveur HTTP : [HTTP Server in Dart](https://www.dartlang.org/articles/io/#writing-web-servers)

Pour le lancer, faite simplement un clic droit. Avec ça, vôtre site web est disponible pour le monde autour de vous, quelqu'un à coté de vous peut taper sur son navigateur 'http://votre_ip:4545/' et Tadaaaa ! le site apparait.

### 2.21 News !!! (mais enfin c'est quoi une news ?)

D'accord c'est super, mais c'est un peu pauvre en fonctionnalitée, pour résoudre ça on va crée un système de génération de news (aléatoire d'abord et plus élaboré pour ceux qui le veulent). 

Pour ca vous allez `import '../web/news.dart'` et ajouter à votre classe `News` une methode `String toJSON()`
> #####Astuce: 'dart:convert' et JSON

Maintenant que vous pouvez sérialiser vos News, vous allez pouvoir remplir la methode `String getNews()` qui doit renvoyer une `List<News>` sous forme de chaine de caractère.
Pour tester le bon fonctionnement de votre fonction, tapez simple 'http://127.0.0.1:4545/getNews' dans votre navigateur.


### Vous voulez une news ? oui en juste une requete. Vous voulez pas une news d'abord ?

Votre serveur est prêt pour envoyer des news à la demande, maintenant retournons sur le client afin de récuperer ces news. Pour les récupérer il faut faire une requête HTTP au serveur pour récupérer les info.

pour ça : [Doc HttpRequest](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart-dom-html.HttpRequest)

> Pour récuper les news, vous pouvez ajouter un constructeur nommé pour construire une News à partir d'un JSON comme ceux ci :

```dart
News(/* ... */);

News.fromJSON(var json) {
 // ...
}
```
> 'dart:convert' et JSON peut encore vous servir ;)

### Tu ne newseras pas !

Notre système à des bases solides, maintenant il faut l'améliorer pour le rendre vraiment sympa. Pour cela on va mettre un petit formulaire pour envoyer des news et les affichers directement.

Pour cela, il y a les ressources disponible dans `Web_part3`, et cela rajoute :

 * [NgRoute](https://angulardart.org/tutorial/08-ch06-view.html) : Angular propose un composent permettant de "simuler" une navigation entre plusieur page, mais sans chargement de la nouvelle par car elle a déjà été préchargée.
 * Une découpe par module avec `news_page.html` et `add_news.html`
 * Un nouveau controller pour la page d'envoie de news

Avec ça et tous ce que l'on a vu avant, cela ne devrait pas être un problème ;)


## C'est Fini, mais pas vraiment !

Voilà, le TP principale est fini, mais vous pouvez continuer en rajoutant :

* un eport RSS de vos news
* Mettre des animations d'entré sur la page `about.html`
* Passer votre app sur android !
* Faire une snake (Pourquoi pas ? si vous voulez de le faire voici un lib pour vous aider : [StageXL](http://pub.dartlang.org/packages/stagexl) )


J'espère que vous vous êtes amusés à faire le TP et surtout que vous avez appris des choses et du Dart.
