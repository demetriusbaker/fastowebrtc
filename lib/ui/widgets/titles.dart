import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:flutter/material.dart';

class Titles extends StatelessWidget {
  final double width;

  const Titles({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    double size;
    if (width > 900) {
      size = 44;
    } else if (width > 800) {
      size = 38;
    } else {
      size = 30;
    }
    final style = TextStyle(fontWeight: FontWeight.bold, fontSize: size);
    const style2 = TextStyle(fontSize: 20, color: subTextColor);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (width > 620)
          Text("$bigPageTitleText1 $bigPageTitleText2", style: style)
        else ...[
          Text(bigPageTitleText1, style: style),
          Text(bigPageTitleText2, style: style),
        ],
        const SizedBox(height: 10),
        Text(subPageTitleText, style: style2),
      ],
    );
  }
}
