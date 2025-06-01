import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kosakata_benda/presentasion/controllers/vocab_controller.dart';
import 'package:kosakata_benda/presentasion/widgets/background.dart';

class MatchingPage extends StatefulWidget {
  const MatchingPage({super.key});

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  final List<Offset> _startPoints = [];
  final List<Offset> _endPoints = [];
  final List<GlobalKey> _imageKeys = [];
  final List<GlobalKey> _textKeys = [];
  final GlobalKey _stackKey = GlobalKey();

  int? _selectedImageIndex;
  Offset? _currentLineStart;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<VocabController>();
    controller.resetMatchGame();
    controller.prepareMatchGame();
  }

  void updateLines() {
    setState(() {
      _startPoints.clear();
      _endPoints.clear();
      _calculatePoints();
    });
  }

  void _calculatePoints() {
    final controller = Get.find<VocabController>();
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;

    for (var pair in controller.matchedLines) {
      final i = pair['imageIndex'];
      final j = pair['textIndex'];
      if (i != null && j != null) {
        final imageBox =
            _imageKeys[i].currentContext?.findRenderObject() as RenderBox?;
        final textBox =
            _textKeys[j].currentContext?.findRenderObject() as RenderBox?;
        if (imageBox != null && textBox != null && stackBox != null) {
          final imageOffset =
              imageBox.localToGlobal(Offset.zero, ancestor: stackBox);
          final textOffset =
              textBox.localToGlobal(Offset.zero, ancestor: stackBox);
          final imageCenter = imageOffset +
              Offset(imageBox.size.width / 2, imageBox.size.height / 2);
          final textCenter = textOffset +
              Offset(textBox.size.width / 2, textBox.size.height / 2);
          _startPoints.add(imageCenter);
          _endPoints.add(textCenter);
        }
      }
    }
  }

  void _showIncorrectDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/wrong.png', // path gambar salah
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 16),
            const Text(
              'Coba lagi, pasangan belum tepat.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    final controller = Get.find<VocabController>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Selesai!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Benar : ${controller.matchCorrectCount.value}'),
            Text('Total Salah: ${controller.matchWrongCount.value}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Kembali ke Menu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VocabController>();

    return WillPopScope(
      onWillPop: () async {
        controller.resetMatchGame();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const Background(),
            Obx(() {
              final images = controller.imageOptions;
              final texts = controller.textOptions;
              final current = controller.currentMatchIndex.value;
              final total = controller.totalMatchQuestions;

              if (_imageKeys.length != images.length) {
                _imageKeys.clear();
                _imageKeys
                    .addAll(List.generate(images.length, (_) => GlobalKey()));
              }
              if (_textKeys.length != texts.length) {
                _textKeys.clear();
                _textKeys
                    .addAll(List.generate(texts.length, (_) => GlobalKey()));
              }

              WidgetsBinding.instance
                  .addPostFrameCallback((_) => updateLines());

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                "MENJODOHKAN KATA",
                                style: TextStyle(
                                  fontFamily: "Borsok",
                                  fontSize: 28,
                                  color: Color(0xffff5757),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (current + 1) / total,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.orange,
                        minHeight: 10,
                      ),
                      const SizedBox(height: 2),
                      Center(
                        child: Text(
                          'Soal ${current + 1} dari $total',
                          style: const TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: Stack(
                          key: _stackKey,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(images.length, (i) {
                                      return _buildImageItem(
                                          i, images[i].image_url);
                                    }),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(texts.length, (j) {
                                      return _buildTextItem(j, texts[j].judul);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            IgnorePointer(
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: _LinePainter(
                                  startPoints: _startPoints,
                                  endPoints: _endPoints,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(int i, String imageUrl) {
    final bool isSelected = _selectedImageIndex == i;

    return GestureDetector(
      onTap: () {
        final imageBox =
            _imageKeys[i].currentContext?.findRenderObject() as RenderBox?;
        final stackBox =
            _stackKey.currentContext?.findRenderObject() as RenderBox?;
        if (imageBox != null && stackBox != null) {
          final imageOffset =
              imageBox.localToGlobal(Offset.zero, ancestor: stackBox);
          final imageCenter = imageOffset +
              Offset(imageBox.size.width / 2, imageBox.size.height / 2);
          setState(() {
            _selectedImageIndex = i;
            _currentLineStart = imageCenter;
          });
        }
      },
      child: Transform.scale(
        scale: isSelected ? 1.1 : 1.0, // zoom in saat selected
        child: Container(
          key: _imageKeys[i],
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.orange : Colors.black,
              width: isSelected ? 4 : 2, // border lebih tebal saat selected
            ),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Colors.orange.withOpacity(0.6) // shadow lebih jelas
                    : Colors.grey.withOpacity(0.3),
                blurRadius: isSelected ? 12 : 4,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextItem(int j, String title) {
    final controller = Get.find<VocabController>();
    return GestureDetector(
      onTap: () {
        if (_selectedImageIndex != null &&
            _selectedImageIndex! < controller.matchedLines.length) {
          final matched = controller.isMatchCorrect(_selectedImageIndex!, j);
          final textBox =
              _textKeys[j].currentContext?.findRenderObject() as RenderBox?;
          final stackBox =
              _stackKey.currentContext?.findRenderObject() as RenderBox?;
          if (matched &&
              _currentLineStart != null &&
              textBox != null &&
              stackBox != null) {
            final textOffset =
                textBox.localToGlobal(Offset.zero, ancestor: stackBox);
            final textCenter = textOffset +
                Offset(textBox.size.width / 2, textBox.size.height / 2);
            setState(() {
              _startPoints.add(_currentLineStart!);
              _endPoints.add(textCenter);
            });
            controller.matchedLines[_selectedImageIndex!] = {
              'imageIndex': _selectedImageIndex!,
              'textIndex': j,
            };
          } else {
            // SALAH → tambah 1
            controller.matchWrongCount.value++;
            _showIncorrectDialog();
          }

          setState(() {
            _selectedImageIndex = null;
            _currentLineStart = null;
          });
          if (controller.matchedLines.every((m) => m['textIndex'] != null)) {
            // PAGE BENAR → tambah 1
            controller.matchCorrectCount.value++;

            Future.delayed(const Duration(milliseconds: 500), () {
              controller.currentMatchIndex.value++;
              if (controller.currentMatchIndex.value <
                  controller.totalMatchQuestions) {
                controller.prepareMatchGame();
              } else {
                _showCompletionDialog();
              }
            });
          }
        }
      },
      child: Container(
        key: _textKeys[j],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueGrey, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(2, 2),
            )
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Borsok",
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<Offset> startPoints;
  final List<Offset> endPoints;

  _LinePainter({required this.startPoints, required this.endPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < startPoints.length; i++) {
      final p1 = startPoints[i];
      final p2 = endPoints[i];
      final cp1 = Offset(p1.dx + 50, p1.dy);
      final cp2 = Offset(p2.dx - 50, p2.dy);

      final path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
