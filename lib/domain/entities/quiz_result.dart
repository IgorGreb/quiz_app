class QuizResult {
  final int score;
  final DateTime date;

  const QuizResult({required this.score, required this.date});

  Map<String, dynamic> toJson() => {
        'score': score,
        'date': date.toIso8601String(),
      };

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      score: json['score'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
}