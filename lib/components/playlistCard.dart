import 'package:flutter/material.dart';
import '../constants/textStyles.dart';
import '../utils/API-Model.dart';


class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    super.key,
    required this.imageUrl,
    required this.text,

  });
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,16,8),
          child: Container(
            height: 150,
            width: 150,
            child: FittedBox(
              child: Image.network(imageUrl),
              fit: BoxFit.fill,
            ),

          ),
        ),
        Text(
          "  "+text,
          style: kMusicInfoStyle,
        ),
      ],
    );
  }
}
