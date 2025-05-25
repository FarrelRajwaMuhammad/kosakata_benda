import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

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
                    "Permainan",
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

          //#Button Tebak Benda
          Positioned(
            left: 130,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                    onPressed: () {
                      Get.toNamed('/TebakBenda');
                    },
                    SVGpath: 'assets/images/53.svg',
                    size: 220),
              ],
            ),
          ),

          //#Button Pasang Huruf
          Positioned(
            left: 305,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                    onPressed: () {
                      Get.toNamed("/PasangHuruf");
                    },
                    SVGpath: 'assets/images/54.svg',
                    size: 220),
              ],
            ),
          ),

          //#Button Menjodohkan Gambar
          Positioned(
            right: 130,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                    onPressed: () {
                      Get.toNamed("/MatchingPage");
                    },
                    SVGpath: 'assets/images/55.svg',
                    size: 220),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            child: IconButton(
              onPressed: () => Get.toNamed('/skrt'),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
