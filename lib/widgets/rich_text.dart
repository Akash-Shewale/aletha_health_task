import 'package:flutter/material.dart';
class RichTextCards extends StatelessWidget {
  final String title;
  final String subTitle;

   const RichTextCards({super.key,required this.title,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: subTitle,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
