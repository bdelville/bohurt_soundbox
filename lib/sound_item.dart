import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

typedef void SoundItemCallback(SoundItemData soundItem);

class SoundItemData {
  SoundItemData(this.iconRes, this.title, this.soundRes);

  SoundItemData.fromJson(dynamic json)
      : iconRes = json['icon'],
        soundRes = json['sound'],
        title = json['title'];

  final String iconRes;
  final String title;
  final String soundRes;
}

class SoundItem extends StatelessWidget {
  SoundItem(this.data, this.onSoundSelected);

  final SoundItemData data;
  final SoundItemCallback onSoundSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Ink.image(
            image: AssetImage("resources/images/${data.iconRes}"),
            child: Container(),
            width: 100,
            height: 100,
          ),
          Text(data.title)
        ],
      ),
      onTap: () {
        onSoundSelected(data);
      },
    );
  }
}
