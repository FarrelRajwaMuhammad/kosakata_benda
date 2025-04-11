import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';
import 'package:kosakata_benda/presentasion/widgets/frame.dart';

class HomeVocab extends StatefulWidget {
  const HomeVocab({super.key});

  @override
  State<HomeVocab> createState() => _HomeVocabState();
}

class _HomeVocabState extends State<HomeVocab> {
  final PageController _controller = PageController(viewportFraction: 1);
  int _currentPage = 0;

  final List<List<Map<String, String>>> _pages = [
    [
      {"image": "assets/images/30.png", "label": "Jendela"},
      {"image": "assets/images/31.png", "label": "Pintu"},
      {"image": "assets/images/32.png", "label": "Vas Bunga"},
    ],
    [
      {"image": "assets/images/33.png", "label": "Kalender"},
      {"image": "assets/images/34.png", "label": "Baju"},
      {"image": "assets/images/35.png", "label": "Celana"},
    ],
    [
      {"image": "assets/images/36.png", "label": "Rok"},
      {"image": "assets/images/37.png", "label": "Payung"},
      {"image": "assets/images/38.png", "label": "Kipas Angin"},
    ],
    [
      {"image": "assets/images/39.png", "label": "Gelas"},
      {"image": "assets/images/40.png", "label": "Piring"},
      {"image": "assets/images/41.png", "label": "Mangkok"},
    ],
    [
      {"image": "assets/images/42.png", "label": "Sendok"},
      {"image": "assets/images/43.png", "label": "Garpu"},
      {"image": "assets/images/44.png", "label": "Pisau"},
    ],
    [
      {"image": "assets/images/45.png", "label": "Sapu"},
      {"image": "assets/images/46.png", "label": "Gunting"},
      {"image": "assets/images/47.png", "label": "Kasur"},
    ],
    [
      {"image": "assets/images/48.png", "label": "Lemari"},
      {"image": "assets/images/49.png", "label": "Sofa"},
      {"image": "assets/images/50.png", "label": "Lampu"},
    ],
    [
      {"image": "assets/images/51.png", "label": "Motor"},
      {"image": "assets/images/52.png", "label": "Mobil"},
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
      body: SafeArea(
        child: Stack(
          children: [
            Background(),
            Column(
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Kosakata Benda",
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 40,
                      color: Color(0xffff914d),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Di Rumah",
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 26,
                      color: Color(0xffff5757),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _controller,
                        itemCount: _pages.length,
                        onPageChanged: (index) =>
                            setState(() => _currentPage = index),
                        itemBuilder: (context, pageIndex) {
                          final items = _pages[pageIndex];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: items.map((item) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              item["label"]!,
                                              style: const TextStyle(
                                                fontFamily: "Borsok",
                                                fontSize: 24,
                                                color: Color(0xff3d6294),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Image.asset(
                                              item["image"]!,
                                              height: 120,
                                            ),
                                            const SizedBox(height: 12),
                                            ElevatedButton(
                                              onPressed: () => Get.back(),
                                              child: const Text("Tutup"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Frame(
                                  imagepath: item["image"]!,
                                  label: item["label"]!,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Positioned(
                        left: 10,
                        top: MediaQuery.of(context).size.height * 0.15,
                        child: ButtonSVG(
                          onPressed: () => _goToPage(_currentPage - 1),
                          SVGpath: 'assets/images/29.svg',
                          size: 90,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: MediaQuery.of(context).size.height * 0.15,
                        child: ButtonSVG(
                          onPressed: () => _goToPage(_currentPage + 1),
                          SVGpath: 'assets/images/28.svg',
                          size: 90,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              top: 10,
              child: IconButton(
                onPressed: () => Get.toNamed('/menu'),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
