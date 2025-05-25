// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kosakata_benda/core/api/game_api.dart';
// import 'package:kosakata_benda/data/models/game_model.dart';
// import 'package:kosakata_benda/data/models/vocab_model.dart';

// void submitAnswer(Vocab selected, Vocab correct) async {
//   final isCorrect = selected.id == correct.id;

//   final game = Game(
//     vocabId: correct.id,
//     gameType: 'tebak',
//     userAnswer: selected.judul,
//     isCorrect: isCorrect,
//     playedAt: DateTime.now(),
//   );

//   await postGameToAPI(game);

//   // Feedback ke user
//   Get.dialog(
//     AlertDialog(
//       title: Text(isCorrect ? "Benar!" : "Salah"),
//       content: Text(isCorrect ? "Jawaban kamu tepat!" : "Coba lagi ya!"),
//       actions: [
//         TextButton(
//           child: const Text("Lanjut"),
//           onPressed: () {
//             Get.back(); // tutup dialog
//             generateQuestion(); // lanjut soal berikutnya
//           },
//         )
//       ],
//     ),
//   );
// }
