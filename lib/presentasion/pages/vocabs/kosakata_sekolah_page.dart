import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/button.dart';
import 'package:kosakata_benda/presentasion/widgets/frame.dart';
import '../../controllers/vocab_controller.dart';

class KosakataSekolah extends StatefulWidget {
  const KosakataSekolah({super.key});

  @override
  State<KosakataSekolah> createState() => _KosakataSekolahState();
}

class _KosakataSekolahState extends State<KosakataSekolah> {
  final PageController _controller = PageController(viewportFraction: 1);
  final VocabController controller = Get.put(VocabController());
  int _currentPage = 0;

  void _goToPage(int index) {
    if (index >= 0 && index < (controller.sekolahVocabs.length / 3).ceil()) {
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
        child: Obx(() => Stack(
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
                            itemCount:
                                (controller.sekolahVocabs.length / 3).ceil(),
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            itemBuilder: (context, index) {
                              final startIndex = index * 3;
                              final endIndex = (startIndex + 3 <
                                      controller.sekolahVocabs.length)
                                  ? startIndex + 3
                                  : controller.sekolahVocabs.length;
                              final items = controller.sekolahVocabs
                                  .sublist(startIndex, endIndex);

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: items.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    item.judul,
                                                    style: const TextStyle(
                                                      fontFamily: "Borsok",
                                                      fontSize: 24,
                                                      color: Color(0xff3d6294),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  item.image_url.isNotEmpty
                                                      ? Image.network(
                                                          item.image_url,
                                                          height: 120,
                                                          errorBuilder: (_, __,
                                                                  ___) =>
                                                              const Icon(
                                                                  Icons.error),
                                                          loadingBuilder: (_,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return const CircularProgressIndicator();
                                                          },
                                                        )
                                                      : const Icon(
                                                          Icons.broken_image,
                                                          size: 120,
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
                                        imagepath: item.image_url,
                                        label: item.judul,
                                      ),
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
            )),
      ),
    );
  }
}
