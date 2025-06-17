import 'package:flutter/material.dart';

class PlainCard extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;

  const PlainCard({required this.itemName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            itemName,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
