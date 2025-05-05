import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/core/materials/color_materials.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';
import 'package:kosakata_benda/presentasion/controllers/audio_controller.dart';

final AudioController audioController = Get.put(AudioController());

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          //setting button
          Positioned(
            left: 10,
            top: 20,
            child: Column(
              children: [
                ButtonSVG(
                  onPressed: () {
                    Get.toNamed('/Option');
                  },
                  SVGpath: 'assets/images/2.svg',
                  size: 100,
                ),
              ],
            ),
          ),
          //sound button
          Positioned(
            left: 10,
            top: 100,
            child: Obx(() => Column(
                  children: [
                    ButtonSVG(
                      onPressed: () {
                        audioController.toggleSound();
                      },
                      SVGpath: audioController.isPlaying.value
                          ? 'assets/images/56.svg'
                          : 'assets/images/4.svg',
                      size: 100,
                    ),
                  ],
                )),
          ),
          //play button
          Positioned(
            right: 170,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                  onPressed: () {
                    Get.toNamed('/MainMenu');
                  },
                  SVGpath: 'assets/images/3.svg',
                  size: 200,
                ),
              ],
            ),
          ),
          //KosaKata button
          Positioned(
            left: 170,
            bottom: 10,
            child: Column(
              children: [
                ButtonSVG(
                  onPressed: () {
                    Get.toNamed('/menu');
                  },
                  SVGpath: 'assets/images/1.svg',
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
