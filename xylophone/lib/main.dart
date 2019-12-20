import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildButtonWithSound(1, Colors.red),
              buildButtonWithSound(2, Colors.orange),
              buildButtonWithSound(3, Colors.yellow),
              buildButtonWithSound(4, Colors.lightGreen),
              buildButtonWithSound(5, Colors.green),
              buildButtonWithSound(6, Colors.blue),
              buildButtonWithSound(7, Colors.purple),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonWithSound(int note, Color color) {
    return Expanded(
      child: FlatButton(
        color: color,
        onPressed: () {
          playSound(note);
        },
      ),
    );
  }

  void playSound(int note) {
    final player = AudioCache();
    player.play('note$note.wav');
  }
}
