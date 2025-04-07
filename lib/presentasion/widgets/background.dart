import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background ({super.key, child, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/yardBackground-Enhance.jpg"),
          fit: BoxFit.cover,
        ),
       ),
      ),
    );
  }
}