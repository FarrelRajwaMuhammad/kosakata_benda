import 'package:flutter/material.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';

class KosakataSekolah extends StatelessWidget {
  const KosakataSekolah({super.key});

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