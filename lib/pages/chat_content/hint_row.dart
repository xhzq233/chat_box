/// xhzq_test - hint_row
/// Created by xhz on 26/04/2022
import 'package:flutter/material.dart';

class HintRow extends StatelessWidget {
  const HintRow({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          content,
          style: const TextStyle(fontWeight: FontWeight.bold),//color: Global.cbOnBackground,
        ),
      ),
    );
  }
}
