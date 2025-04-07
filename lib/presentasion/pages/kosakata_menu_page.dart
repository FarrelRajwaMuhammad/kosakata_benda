import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';

class KosakataMenu extends StatelessWidget {
  const KosakataMenu({super.key});

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
                    "Belajar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 60,
                      color: Color(0xff3d6294),
                    ),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Kosakata ",
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 60,
                      color: Color(0xffff914d),
                    ),
                    children: [
                      TextSpan(
                        text: "Benda",
                        style: TextStyle(
                          fontFamily: "Borsok",
                          fontSize: 60,
                          color: Color(0xffff5757),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50), // Beri jarak
            ],
          ),
          Positioned(
                left: 10,
                top: 20,
                child: Column(
                  children: [
                    ButtonSVG(
                      onPressed: () {
                        Get.toNamed('/');
                      },
                      SVGpath: 'assets/images/Untitled design.svg',
                      size: 100,
                    ),
                  ],
                ),
              ),
          //
          Positioned(
            right: 170,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                  onPressed: () {
                    Get.toNamed('/EduVocab');
                  },
                  SVGpath: 'assets/images/5.svg',
                  size: 200,
                ),
              ],
            ),
          ),
          //achievement button
          Positioned(
            left: 170,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                  onPressed: () {
                    print("dipencet");
                  },
                  SVGpath: 'assets/images/6.svg',
                  size: 200,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
