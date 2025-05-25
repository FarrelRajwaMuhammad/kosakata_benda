// === FINAL CONTROLLER FIX ===
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

  var currentVocab = Rx<Vocab?>(null);
  var shuffledLetters = <String>[].obs;
  var droppedLetters = <String?>[].obs;
  var totalQuestions = 10;
  var currentQuestionIndex = 0.obs;
  var dragGameVocabs = <Vocab>[].obs;
  final Map<String, int> letterFrequency = {};

  var matchGameVocabs = <Vocab>[].obs;
  var currentMatchIndex = 0.obs;
  var imageOptions = <Vocab>[].obs;
  var textOptions = <Vocab>[].obs;
  var matchedLines = <Map<String, int?>>[].obs;
  var totalMatchQuestions = 10;

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

    final game = Game(
      vocabId: correct.id!,
      gameType: 'tebak',
      userAnswer: selected.judul,
      isCorrect: isCorrect,
      playedAt: DateTime.now(),
    );

    Get.dialog(
      AlertDialog(
        title: Text(isCorrect ? "Benar!" : "Salah"),
        content: Text(isCorrect ? "Jawaban kamu tepat!" : "Coba lagi ya!"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              generateQuestion();
            },
            child: const Text("Lanjut"),
          ),
        ],
      ),
    );
  }

  void prepareDragGame() {
    if (vocabs.isEmpty) return;

    if (dragGameVocabs.isEmpty ||
        currentQuestionIndex.value >= totalQuestions) {
      final availableCount =
          vocabs.length < totalQuestions ? vocabs.length : totalQuestions;
      vocabs.shuffle();
      dragGameVocabs.value = vocabs.take(availableCount).toList();
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
    Get.dialog(AlertDialog(
      title: Text(correct ? "Benar!" : "Salah"),
      content:
          Text(correct ? "Kamu menyusun dengan benar!" : "Coba lagi, yuk!"),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            currentQuestionIndex.value++;
            if (currentQuestionIndex.value < dragGameVocabs.length) {
              prepareDragGame();
            } else {
              Get.dialog(AlertDialog(
                title: const Text("Selesai"),
                content: const Text("Kamu telah menyelesaikan semua soal!"),
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
        )
      ],
    ));
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
