import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';

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
      mainAxisSize: MainAxisSize.min,
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
