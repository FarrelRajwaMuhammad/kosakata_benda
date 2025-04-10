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
    return SizedBox(
      width:
          MediaQuery.of(context).size.width * 0.25, // Atur lebar frame di sini
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(6),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Image.asset(imagepath, fit: BoxFit.contain),
                ),
                const SizedBox(height: 6),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
