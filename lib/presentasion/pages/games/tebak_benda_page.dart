import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';

class TebakBenda extends StatelessWidget {
  const TebakBenda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Center(
                  child: Text(
                    'Tebak Benda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 40,
                      color: Color(0xffff5757),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 20,
            child: IconButton(
              onPressed: () => Get.toNamed('/MainMenu'),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
