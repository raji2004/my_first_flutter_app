import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/screens/index.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 12, 59)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random();
  List<WordPair> fav = [];
  Icon favicon = Icon(Icons.favorite_border_outlined);
  void NextWord() {
    favicon = Icon(Icons.favorite_border_outlined);
    current = WordPair.random();
    notifyListeners(); //notify the listeners that data has changed and rebuild UI with new values of current word pair
  }

  void AddFav() {
    if (fav.contains(current)) {
      favicon = Icon(Icons.favorite_border_outlined);
      fav.remove(current);
    } else {
      favicon = Icon(Icons.favorite);
      fav.add(current);
    }
    print(fav);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ...

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavouritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

// ...

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 4,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() => selectedIndex = value);
            },
          ),
        ],
      ),
    );
  }
}



