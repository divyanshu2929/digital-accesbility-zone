import 'package:flutter/material.dart';

class ZoneCell extends StatelessWidget {

  final int label;

  ZoneCell(this.label);

  Color getColor() {

    if (label == 2) return Colors.green;
    if (label == 1) return Colors.yellow;

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: getColor(),
      child: Center(
        child: Text(
          "Zone",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}