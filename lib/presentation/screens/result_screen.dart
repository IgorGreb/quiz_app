import 'package:flutter/material.dart';
import '../../data/models/question_model.dart';
import 'history_screen.dart';
import '../providers/quiz_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  final List<int> selectedAnswers;
  final List<Question> questions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Your score: $score / ${questions.length}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...List.generate(questions.length, (i) {
              final q = questions[i];
              final userAnswer = selectedAnswers[i];
              final correct = userAnswer == q.correctIndex;
              return Card(
                color: correct ? Colors.green[100] : Colors.red[100],
                child: ListTile(
                  title: Text(q.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text("Your answer: ${q.options[userAnswer]}"),
                      Text("Correct answer: ${q.options[q.correctIndex]}"),
                      if (q.explanation != null) ...[
                        const SizedBox(height: 6),
                        Text("💡 ${q.explanation!}", style: const TextStyle(fontStyle: FontStyle.italic)),
                      ]
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(quizProvider.notifier).reset();
                Navigator.pushReplacementNamed(context, '/quiz');
              },
              child: const Text("Try Again"),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
              child: const Text("View History"),
            ),
          ],
        ),
      ),
    );
  }
}