import 'package:flutter/material.dart';

class TitleTag extends StatelessWidget {
  final String title;
  TitleTag(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Oswald', fontSize: 26.0),
    );
  }
}