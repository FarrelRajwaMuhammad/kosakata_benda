import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/core/api/vocab_api.dart';
import 'package:kosakata_benda/data/models/game_model.dart';
import 'package:kosakata_benda/data/models/vocab_model.dart';

class VocabController extends GetxController {
  var vocabs = <Vocab>[].obs;
  var rumahVocabs = <Vocab>[].obs;
  var sekolahVocabs = <Vocab>[].obs;
  var isLoading = false.obs;
  var currentQuestion = Rx<Vocab?>(null);
  var options = <Vocab>[].obs;
  var tebakCorrectCount = 0.obs;
  var tebakWrongCount = 0.obs;

  var currentVocab = Rx<Vocab?>(null);
  var shuffledLetters = <String>[].obs;
  var droppedLetters = <String?>[].obs;
  var totalQuestions = 10;
  var currentQuestionIndex = 0.obs;
  var dragGameVocabs = <Vocab>[].obs;
  final Map<String, int> letterFrequency = {};
  var matchCorrectCount = 0.obs;
  var matchWrongCount = 0.obs;

  var matchGameVocabs = <Vocab>[].obs;
  var currentMatchIndex = 0.obs;
  var imageOptions = <Vocab>[].obs;
  var textOptions = <Vocab>[].obs;
  var matchedLines = <Map<String, int?>>[].obs;
  var totalMatchQuestions = 10;
  var matchCorrectPages = 0.obs; // per page

  @override
  void onInit() {
    super.onInit();
    loadVocabs();
  }

  void loadVocabs() async {
    isLoading.value = true;
    try {
      final allVocabs = await VocabApi.fetchVocabs();
      vocabs.value = allVocabs;
      rumahVocabs.value =
          allVocabs.where((e) => e.category.toLowerCase() == 'rumah').toList();
      sekolahVocabs.value = allVocabs
          .where((e) => e.category.toLowerCase() == 'sekolah')
          .toList();

      if (vocabs.isNotEmpty) {
        generateQuestion();
        prepareMatchGame();
      }
    } catch (e) {
      print('Error load vocab: $e');
    }
    isLoading.value = false;
  }

  void generateQuestion() {
    if (vocabs.length < 3) return;
    final shuffled = [...vocabs]..shuffle();
    currentQuestion.value = shuffled.first;
    options.value = [shuffled.first, ...shuffled.skip(1).take(2)];
    options.shuffle();
  }

  void submitAnswer(Vocab selected, Vocab correct) async {
    if (selected.id == null || correct.id == null) return;
    final isCorrect = selected.id == correct.id;

    // Simpan game log
    final game = Game(
      vocabId: correct.id!,
      gameType: 'tebak',
      userAnswer: selected.judul,
      isCorrect: isCorrect,
      playedAt: DateTime.now(),
    );

    // Update counter
    if (isCorrect) {
      tebakCorrectCount.value++;
    } else {
      tebakWrongCount.value++;
    }

    // Cek apakah sudah selesai 10 soal
    if (currentQuestionIndex.value + 1 >= totalQuestions) {
      // Modal selesai
      Get.dialog(AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.celebration, color: Colors.blue, size: 100),
            const SizedBox(height: 16),
            const Text(
              "Kamu telah menyelesaikan semua soal!",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text("Total Benar: ${tebakCorrectCount.value}"),
            Text("Total Salah: ${tebakWrongCount.value}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Reset game
              tebakCorrectCount.value = 0;
              tebakWrongCount.value = 0;
              currentQuestionIndex.value = 0;
              generateQuestion();
              Get.back();
            },
            child: const Text("Main Lagi"),
          ),
          TextButton(
            onPressed: () {
              // Kembali ke menu
              tebakCorrectCount.value = 0;
              tebakWrongCount.value = 0;
              currentQuestionIndex.value = 0;
              Get.back();
              Get.back();
            },
            child: const Text("Kembali ke Menu"),
          ),
        ],
      ));
    } else {
      // Modal jawaban
      Get.dialog(AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCorrect)
              Icon(Icons.check_circle, color: Colors.green, size: 150)
            else
              Image.asset(
                'assets/images/wrong.png',
                width: 150,
                height: 150,
              ),
            const SizedBox(height: 16),
            Text(
              isCorrect ? "Jawaban kamu tepat!" : "Coba lagi ya!",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              currentQuestionIndex.value++;
              generateQuestion();
            },
            child: const Text("Lanjut"),
          ),
        ],
      ));
    }
  }

  void prepareDragGame() {
    if (vocabs.isEmpty) return;

    // Filter vocab: tanpa spasi dan tidak panjang (contoh: max 8 karakter)
    final filteredVocabs = vocabs
        .where((v) => !v.judul.contains(' ') && v.judul.length <= 8)
        .toList();

    if (filteredVocabs.isEmpty) return;

    if (dragGameVocabs.isEmpty ||
        currentQuestionIndex.value >= totalQuestions) {
      final availableCount = filteredVocabs.length < totalQuestions
          ? filteredVocabs.length
          : totalQuestions;
      filteredVocabs.shuffle();
      dragGameVocabs.value = filteredVocabs.take(availableCount).toList();
      currentQuestionIndex.value = 0;
    }

    final vocab = dragGameVocabs[currentQuestionIndex.value];
    currentVocab.value = vocab;

    final letters = vocab.judul.toLowerCase().split('');
    shuffledLetters.value = [...letters]..shuffle();
    droppedLetters.value = List<String?>.filled(letters.length, null).toList();

    letterFrequency.clear();
    for (var l in letters) {
      letterFrequency[l] = (letterFrequency[l] ?? 0) + 1;
    }
  }

  void dropLetter(String letter, int index) {
    final oldLetter = droppedLetters[index];
    if (oldLetter == letter) return;

    int usedCount = droppedLetters.where((l) => l == letter).length;
    int maxAllowed = letterFrequency[letter] ?? 0;

    if (oldLetter != null && oldLetter != letter) {
      int oldLetterCount = droppedLetters.where((l) => l == oldLetter).length;
      if (oldLetterCount > (letterFrequency[oldLetter] ?? 0)) {
        droppedLetters[index] = null;
        update();
        return;
      }
    }

    if (usedCount >= maxAllowed && oldLetter != letter) return;

    droppedLetters[index] = letter;
    update();

    if (!droppedLetters.contains(null)) {
      Future.delayed(const Duration(milliseconds: 300), () {
        checkDragAnswer();
      });
    }
  }

  void removeDroppedLetter(int index) {
    droppedLetters[index] = null;
    update();
  }

  bool isAnswerCorrect() {
    final currentWord = droppedLetters.join();
    return currentWord == currentVocab.value?.judul.toLowerCase();
  }

  void checkDragAnswer() {
    final correct = isAnswerCorrect();

    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (correct)
              Icon(Icons.check_circle, color: Colors.green, size: 150)
            else
              Image.asset(
                'assets/images/wrong.png', // path gambar salah
                width: 150,
                height: 150,
              ),
            const SizedBox(height: 16),
            Text(
              correct ? "Kamu menyusun dengan benar!" : "Coba lagi, yuk!",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              currentQuestionIndex.value++;
              if (currentQuestionIndex.value < dragGameVocabs.length) {
                prepareDragGame();
              } else {
                Get.dialog(AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.celebration, color: Colors.blue, size: 150),
                      const SizedBox(height: 16),
                      const Text(
                        "Kamu telah menyelesaikan semua soal!",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        dragGameVocabs.clear();
                        currentQuestionIndex.value = 0;
                        currentVocab.value = null;
                        Get.back();
                        Get.back();
                      },
                      child: const Text("Kembali"),
                    ),
                  ],
                ));
              }
            },
            child: const Text("Lanjut"),
          ),
        ],
      ),
    );
  }

  int usedLetterCount(String letter) {
    return droppedLetters.where((l) => l == letter).length;
  }

  bool canUseLetter(String letter) {
    final used = usedLetterCount(letter);
    final maxAllowed = letterFrequency[letter] ?? 0;
    return used < maxAllowed;
  }

  bool isLetterFullyUsed(String letter) {
    final used = usedLetterCount(letter);
    final maxAllowed = letterFrequency[letter] ?? 0;
    return used >= maxAllowed;
  }

  void resetDragGame() {
    dragGameVocabs.clear();
    currentQuestionIndex.value = 0;
    currentVocab.value = null;
    shuffledLetters.clear();
    droppedLetters.clear();
  }

  void resetMatchGame() {
    matchGameVocabs.clear();
    currentMatchIndex.value = 0;
    imageOptions.clear();
    textOptions.clear();
    matchedLines.clear();
  }

  void prepareMatchGame() {
    if (vocabs.length < totalMatchQuestions * 2) return;

    if (matchGameVocabs.isEmpty) {
      vocabs.shuffle();
      matchGameVocabs.value = vocabs.take(totalMatchQuestions * 2).toList();
      matchCorrectCount.value = 0; // Reset benar
      matchWrongCount.value = 0; // Reset salah
    }

    final start = currentMatchIndex.value * 2;
    if (start + 1 >= matchGameVocabs.length) return;

    final currentSlice = matchGameVocabs.sublist(start, start + 2);

    imageOptions.value = currentSlice;
    textOptions.value = [...currentSlice]..shuffle();

    matchedLines.value = List.generate(
      imageOptions.length,
      (_) => {'imageIndex': null, 'textIndex': null},
    );
  }

  bool isMatchCorrect(int imageIdx, int textIdx) {
    if (imageIdx >= imageOptions.length || textIdx >= textOptions.length)
      return false;
    return imageOptions[imageIdx].id == textOptions[textIdx].id;
  }
}
