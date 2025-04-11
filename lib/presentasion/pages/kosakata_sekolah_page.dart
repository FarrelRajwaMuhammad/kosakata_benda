import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';
import 'package:kosakata_benda/presentasion/widgets/frame.dart';

class KosakataSekolah extends StatefulWidget {
  const KosakataSekolah({super.key});

  @override
  State<KosakataSekolah> createState() => _KosakataSekolahState();
}

class _KosakataSekolahState extends State<KosakataSekolah> {
  final PageController _controller = PageController(viewportFraction: 1);
  int _currentPage = 0;

  final List<List<Map<String, String>>> _pages = [
    [
      {"image": "assets/images/8.png", "label": "Papan Tulis"},
      {"image": "assets/images/9.png", "label": "Meja"},
      {"image": "assets/images/10.png", "label": "Kursi"},
    ],
    [
      {"image": "assets/images/11.png", "label": "Tas"},
      {"image": "assets/images/12.png", "label": "Kotak Pensil"},
      {"image": "assets/images/13.png", "label": "Spidol"},
    ],
    [
      {"image": "assets/images/14.png", "label": "Pulpen"},
      {"image": "assets/images/15.png", "label": "Pensil"},
      {"image": "assets/images/16.png", "label": "Penghapus"},
    ],
    [
      {"image": "assets/images/17.png", "label": "Pensil Warna"},
      {"image": "assets/images/18.png", "label": "Serutan"},
      {"image": "assets/images/19.png", "label": "Penggaris"},
    ],
    [
      {"image": "assets/images/20.png", "label": "Buku"},
      {"image": "assets/images/21.png", "label": "Lem"},
      {"image": "assets/images/22.png", "label": "Bendera"},
    ],
    [
      {"image": "assets/images/23.png", "label": "Bola"},
      {"image": "assets/images/24.png", "label": "Jam Dinding"},
      {"image": "assets/images/25.png", "label": "Tempat Sampah"},
    ],
    [
      {"image": "assets/images/26.png", "label": "Calculator"},
      {"image": "assets/images/27.png", "label": "Laptop"},
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
                    "Di Sekolah",
                    style: TextStyle(
                      fontFamily: "Borsok",
                      fontSize: 26,
                      color: Color(0xff3d6294),
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
