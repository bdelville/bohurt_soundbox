import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sound_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buhurt Soundboard',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<List<SoundItemData>>(
    future: loadBoxes(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Text("Error");

      var boxesWidget = snapshot.data!
          .map((dataItem) => SoundItem(dataItem, playSound))
          .toList();

      return Scaffold(
          appBar: AppBar(
            title: Text('Buhurt Soundboard'),
          ),
          body: Center(
            child: GridView.count(
                crossAxisCount: 3,
                children: boxesWidget
            ),
          ));
    },
  );
}

/// Load the list of sounds to display
Future<List<SoundItemData>> loadBoxes() async {
  String jsonData = await rootBundle.loadString('resources/soundboxes.json');

  return (jsonDecode(jsonData)['boxes'] as List)
      .map((tags) => SoundItemData.fromJson(tags))
      .toList(growable: false);
}

final audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY)
  ..setReleaseMode(ReleaseMode.STOP)
  ..setVolume(1.0);

final AudioCache player = AudioCache(
  prefix: 'resources/sounds/',
  fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
);

void playSound(SoundItemData dataItem) {
  player.play("${dataItem.soundRes}");
}