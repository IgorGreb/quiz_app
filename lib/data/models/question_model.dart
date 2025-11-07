class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });
}