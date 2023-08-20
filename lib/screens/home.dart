import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/widget/widget.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    var icon = appState.favicon;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BigCard(pair: pair),
        SizedBox(height: MediaQuery.of(context).size.width * .04),
        RowButtons(appState: appState, favicon: icon),
      ],
    );
  }
}
