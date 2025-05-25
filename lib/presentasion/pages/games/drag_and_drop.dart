import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/controllers/vocab_controller.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';

class SusunHurufPage extends StatelessWidget {
  const SusunHurufPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VocabController>(
      initState: (_) {
        final controller = Get.find<VocabController>();
        controller.resetDragGame();
        controller.prepareDragGame();
      },
      builder: (vocabController) {
        return WillPopScope(
          onWillPop: () async {
            vocabController.resetDragGame();
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                const Background(),
                Obx(() {
                  if (vocabController.isLoading.value ||
                      vocabController.currentVocab.value == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final vocab = vocabController.currentVocab.value!;
                  final letters = vocabController.shuffledLetters;
                  final dropped = vocabController.droppedLetters;
                  final questionIndex =
                      vocabController.currentQuestionIndex.value;
                  final total = vocabController.totalQuestions;

                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Susun Huruf',
                                style: TextStyle(
                                  fontFamily: "Borsok",
                                  fontSize: 30,
                                  color: Color(0xffff5757),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: LinearProgressIndicator(
                                  value: (questionIndex + 1) / total,
                                  backgroundColor: Colors.grey.shade300,
                                  color: Colors.orange,
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Soal ${questionIndex + 1} dari $total'),
                              const SizedBox(height: 20),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(
                                  vocab.image_url,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image, size: 100),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 8,
                                children:
                                    List.generate(dropped.length, (index) {
                                  final letter = dropped[index];
                                  return DragTarget<String>(
                                    builder: (context, candidate, rejected) {
                                      return GestureDetector(
                                        onTap: () => vocabController
                                            .removeDroppedLetter(index),
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: letter != null
                                                ? Colors.orange.shade300
                                                : Colors.white,
                                            border: Border.all(
                                                color: Colors.deepOrange),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            letter?.toUpperCase() ?? '',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: letter != null
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onAccept: (letter) {
                                      vocabController.dropLetter(letter, index);
                                    },
                                    onWillAccept: (_) => true,
                                  );
                                }),
                              ),
                              const SizedBox(height: 20),
                              Obx(() => Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: letters.map((letter) {
                                      final canUse =
                                          vocabController.canUseLetter(letter);
                                      return canUse
                                          ? Draggable<String>(
                                              data: letter,
                                              feedback: Material(
                                                color: Colors.transparent,
                                                child: _buildDraggableLetter(
                                                    letter),
                                              ),
                                              childWhenDragging: Opacity(
                                                opacity: 0.3,
                                                child: _buildDraggableLetter(
                                                    letter),
                                              ),
                                              child:
                                                  _buildDraggableLetter(letter),
                                            )
                                          : Opacity(
                                              opacity: 0.3,
                                              child:
                                                  _buildDisabledLetter(letter),
                                            );
                                    }).toList(),
                                  )),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                Positioned(
                  left: 0,
                  top: 20,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDraggableLetter(String letter) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter.toUpperCase(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDisabledLetter(String letter) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        letter.toUpperCase(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
