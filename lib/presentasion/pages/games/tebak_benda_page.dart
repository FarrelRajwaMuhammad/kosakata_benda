import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';
import 'package:kosakata_benda/presentasion/widgets/frame.dart';
import 'package:kosakata_benda/presentasion/controllers/vocab_controller.dart';

class TebakBenda extends StatelessWidget {
  const TebakBenda({super.key});

  @override
  Widget build(BuildContext context) {
    final vocabController = Get.find<VocabController>();

    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Obx(() {
            if (vocabController.isLoading.value ||
                vocabController.currentQuestion.value == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final soal = vocabController.currentQuestion.value!;
            final options = vocabController.options;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20), // agar tidak nempel bawah
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Tebak Benda',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: "Borsok",
                            fontSize: 30,
                            color: Color(0xffff5757),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              const TextSpan(text: 'Tunjukkan benda '),
                              TextSpan(
                                text:
                                    '"${soal.judul}"\n', // pakai \n supaya baris baru
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Soal ${vocabController.currentQuestionIndex.value + 1}/${vocabController.totalQuestions}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: options.map((vocab) {
                          return GestureDetector(
                            onTap: () {
                              final current =
                                  vocabController.currentQuestion.value;
                              print("Selected vocab: ${vocab.judul}");
                              if (current != null) {
                                print("Current question: ${current.judul}");
                                vocabController.submitAnswer(vocab, current);
                              } else {
                                print("Current question is null");
                              }
                            },
                            child: Frame(
                              imagepath: vocab.image_url,
                              label: vocab.judul,
                              isCircle: true,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
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
