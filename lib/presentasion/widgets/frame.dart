import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final String imagepath;
  final String label;

  const Frame({
    Key? key,
    required this.imagepath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(4),
      child: Container(
        width: 200,
        height: 250,
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagepath, height: 200),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
