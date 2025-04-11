import 'package:flutter/material.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';

class TebakBenda extends StatelessWidget {
  const TebakBenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
        ],
      ),
    );
  }
}
