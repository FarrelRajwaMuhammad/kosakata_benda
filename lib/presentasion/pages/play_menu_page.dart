import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';

class PlayMenuPage extends StatelessWidget {
  const PlayMenuPage ({super.key});

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
          //play button
           Positioned(
            right: 170,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                    onPressed: () {
                      print("dipencet");
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