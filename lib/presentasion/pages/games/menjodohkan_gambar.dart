// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kosakata_benda/presentasion/controllers/vocab_controller.dart';
// import 'package:kosakata_benda/presentasion/widgets/background.dart';

// class MatchingPage extends StatefulWidget {
//   const MatchingPage({super.key});

//   @override
//   State<MatchingPage> createState() => _MatchingPageState();
// }

// class _MatchingPageState extends State<MatchingPage> {
//   final GlobalKey _stackKey = GlobalKey();
//   final List<Offset?> _imageOffsets = [];
//   final List<Offset?> _textOffsets = [];
//   int? _selectedImageIndex;

//   @override
//   void initState() {
//     super.initState();
//     final controller = Get.find<VocabController>();
//     controller.resetMatchGame();
//     controller.prepareMatchGame();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<VocabController>();

//     return WillPopScope(
//       onWillPop: () async {
//         controller.resetMatchGame();
//         return true;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Obx(() {
//             final images = controller.imageOptions;
//             final texts = controller.textOptions;
//             final current = controller.currentMatchIndex.value;
//             final total = controller.totalMatchQuestions;

//             _imageOffsets.length = images.length;
//             _textOffsets.length = texts.length;

//             return Stack(
//               key: _stackKey,
//               children: [
//                 const Background(),
//                 Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     const Text(
//                       "MENJODOHKAN KATA",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                       child: LinearProgressIndicator(
//                         value: (current + 1) / total,
//                         backgroundColor: Colors.grey.shade300,
//                         color: Colors.blue,
//                         minHeight: 10,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text('Soal ${current + 1} dari $total'),
//                     const SizedBox(height: 12),
//                     Expanded(
//                       child: LayoutBuilder(
//                         builder: (context, constraints) {
//                           return Stack(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children:
//                                           List.generate(images.length, (i) {
//                                         return LayoutBuilder(
//                                           builder: (ctx, box) {
//                                             WidgetsBinding.instance
//                                                 .addPostFrameCallback((_) {
//                                               final renderBox =
//                                                   ctx.findRenderObject()
//                                                       as RenderBox?;
//                                               final stackBox = _stackKey
//                                                       .currentContext
//                                                       ?.findRenderObject()
//                                                   as RenderBox?;
//                                               final offset = renderBox
//                                                   ?.localToGlobal(Offset.zero,
//                                                       ancestor: stackBox);
//                                               if (offset != null) {
//                                                 _imageOffsets[i] = offset;
//                                               }
//                                             });
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _selectedImageIndex = i;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 margin: const EdgeInsets.all(8),
//                                                 width: 100,
//                                                 height: 100,
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color:
//                                                           _selectedImageIndex ==
//                                                                   i
//                                                               ? Colors.orange
//                                                               : Colors.black),
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: Image.network(
//                                                   images[i].image_url,
//                                                   fit: BoxFit.contain,
//                                                   errorBuilder: (_, __, ___) =>
//                                                       const Icon(
//                                                           Icons.broken_image),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children:
//                                           List.generate(texts.length, (j) {
//                                         return LayoutBuilder(
//                                           builder: (ctx, box) {
//                                             WidgetsBinding.instance
//                                                 .addPostFrameCallback((_) {
//                                               final renderBox =
//                                                   ctx.findRenderObject()
//                                                       as RenderBox?;
//                                               final stackBox = _stackKey
//                                                       .currentContext
//                                                       ?.findRenderObject()
//                                                   as RenderBox?;
//                                               final offset = renderBox
//                                                   ?.localToGlobal(Offset.zero,
//                                                       ancestor: stackBox);
//                                               if (offset != null) {
//                                                 _textOffsets[j] = offset;
//                                               }
//                                             });
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 if (_selectedImageIndex !=
//                                                     null) {
//                                                   final matched =
//                                                       controller.isMatchCorrect(
//                                                           _selectedImageIndex!,
//                                                           j);
//                                                   if (matched) {
//                                                     controller.matchedLines[
//                                                         _selectedImageIndex!] = {
//                                                       'imageIndex':
//                                                           _selectedImageIndex!,
//                                                       'textIndex': j,
//                                                     };
//                                                   } else {
//                                                     ScaffoldMessenger.of(
//                                                             context)
//                                                         .showSnackBar(
//                                                       const SnackBar(
//                                                         content: Text(
//                                                             'Coba lagi, belum cocok!'),
//                                                       ),
//                                                     );
//                                                   }
//                                                   setState(() {
//                                                     _selectedImageIndex = null;
//                                                   });

//                                                   if (controller.matchedLines
//                                                       .every((m) =>
//                                                           m['textIndex'] !=
//                                                           null)) {
//                                                     Future.delayed(
//                                                         const Duration(
//                                                             milliseconds: 500),
//                                                         () {
//                                                       controller
//                                                           .currentMatchIndex
//                                                           .value++;
//                                                       if (controller
//                                                               .currentMatchIndex
//                                                               .value <
//                                                           controller
//                                                               .totalMatchQuestions) {
//                                                         controller
//                                                             .prepareMatchGame();
//                                                       } else {
//                                                         Get.dialog(
//                                                             const AlertDialog(
//                                                           title:
//                                                               Text("Selesai"),
//                                                           content: Text(
//                                                               "Kamu telah menjodohkan semua dengan benar!"),
//                                                         ));
//                                                       }
//                                                     });
//                                                   }
//                                                 }
//                                               },
//                                               child: Container(
//                                                 margin: const EdgeInsets.all(8),
//                                                 padding:
//                                                     const EdgeInsets.all(12),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(),
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Text(
//                                                   texts[j].judul,
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               CustomPaint(
//                                 painter: _LinePainter(
//                                   imageOffsets: _imageOffsets,
//                                   textOffsets: _textOffsets,
//                                   matched: controller.matchedLines,
//                                 ),
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// class _LinePainter extends CustomPainter {
//   final List<Offset?> imageOffsets;
//   final List<Offset?> textOffsets;
//   final List<Map<String, int?>> matched;

//   _LinePainter({
//     required this.imageOffsets,
//     required this.textOffsets,
//     required this.matched,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.green
//       ..strokeWidth = 2;

//     for (var pair in matched) {
//       final i = pair['imageIndex'];
//       final j = pair['textIndex'];

//       if (i != null &&
//           j != null &&
//           i < imageOffsets.length &&
//           j < textOffsets.length &&
//           imageOffsets[i] != null &&
//           textOffsets[j] != null) {
//         final start = imageOffsets[i]! + const Offset(100, 50);
//         final end = textOffsets[j]! + const Offset(0, 25);
//         canvas.drawLine(start, end, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
