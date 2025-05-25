class Game {
  final int vocabId;
  final String gameType;
  final String userAnswer;
  final bool isCorrect;
  final DateTime playedAt;

  Game({
    required this.vocabId,
    required this.gameType,
    required this.userAnswer,
    required this.isCorrect,
    required this.playedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'vocab_id': vocabId,
      'game_type': gameType,
      'user_answer': userAnswer,
      'is_correct': isCorrect,
      'played_at': playedAt.toUtc().toIso8601String(),
    };
  }
}
