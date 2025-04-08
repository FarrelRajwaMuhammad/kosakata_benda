import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';
import 'package:kosakata_benda/presentasion/widgets/frame.dart';

int currentPage = 0;

class HomeVocab extends StatefulWidget {
  const HomeVocab ({super.key});

  @override
  State<HomeVocab> createState() => _HomeVocab();
}

class _HomeVocab extends State<HomeVocab> {
  final PageController _controller = PageController(viewportFraction: 1);
  int _currentPage = 0;

  final List<List<Map<String, String>>> _pages = [
    [
      {"image": "assets/images/8.png", "label": "Papan Tulis"},
      {"image": "assets/images/9.png", "label": "Meja"},
      {"image": "assets/images/10.png", "label": "Kursi"},
    ],
    [
      {"image": "assets/images/11.png", "label": "Buku"},
      {"image": "assets/images/12.png", "label": "Pensil"},
      {"image": "assets/images/13.png", "label": "Penghapus"},
    ],
    [
      {"image": "assets/images/14.png", "label": "Buku"},
      {"image": "assets/images/15.png", "label": "Pensil"},
      {"image": "assets/images/16.png", "label": "Penghapus"},
    ],
    [
      {"image": "assets/images/17.png", "label": "Buku"},
      {"image": "assets/images/18.png", "label": "Pensil"},
      {"image": "assets/images/19.png", "label": "Penghapus"},
    ],
    [
      {"image": "assets/images/20.png", "label": "Buku"},
      {"image": "assets/images/21.png", "label": "Pensil"},
      {"image": "assets/images/22.png", "label": "Penghapus"},
    ],
    [
      {"image": "assets/images/23.png", "label": "Buku"},
      {"image": "assets/images/24.png", "label": "Pensil"},
      {"image": "assets/images/25.png", "label": "Pensil"},
    ],
    [
      {"image": "assets/images/26.png", "label": "Buku"},
      {"image": "assets/images/27.png", "label": "Pensil"},
    ],
  ];

  void _goToPage(int index) {
    if (index >= 0 && index < _pages.length) {
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            children: [
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  "Kosakata Benda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Borsok",
                    fontSize: 50,
                    color: Color(0xffff914d),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Di Rumah",
                  style: TextStyle(
                    fontFamily: "Borsok",
                    fontSize: 30,
                    color: Color(0xffff5757),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 235,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (context, pageIndex) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _pages[pageIndex]
                              .map((item) => Frame(
                                    imagepath: item["image"]!,
                                    label: item["label"]!,
                                  ))
                              .toList(),
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      top: 80,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => _goToPage(_currentPage - 1),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 80,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () => _goToPage(_currentPage + 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 20,
            child: IconButton(
              onPressed: () {
                Get.toNamed('/menu');
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
