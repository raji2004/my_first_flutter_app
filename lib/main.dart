import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    WordPair pair = appState.current;
    Icon favicon = appState.favicon;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: MediaQuery.of(context).size.width * .04),
            RowButtons(appState: appState, favicon: favicon),
          ],
        ),
      ),
    );
  }
}

class RowButtons extends StatelessWidget {
  const RowButtons({
    super.key,
    required this.appState,
    required this.favicon,
  });

  final MyAppState appState;
  final Icon favicon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            appState.AddFav();
          },
          icon: favicon,
          label: Text("like"),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .05,
        ),
        ElevatedButton(
          onPressed: appState.NextWord,
          child: Text('Next'),
        ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase,
          style: style,
        ),
      ),
    );
  }
}
