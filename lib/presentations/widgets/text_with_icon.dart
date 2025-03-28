import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextDirection textDirection;

  const TextWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textDirection = Directionality.of(context);
    if (textDirection == TextDirection.rtl) {
      return Row(
        textDirection: textDirection,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 8.0),
          Text(text),
        ],
      );
    } else {
      return Row(
        textDirection: textDirection,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(text),
          const SizedBox(width: 8.0),
          Icon(
            icon,
          ),
        ],
      );
    }
  }
}
