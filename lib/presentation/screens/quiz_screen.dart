import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider);
    final ctrl = ref.read(quizProvider.notifier);
    final questions = ctrl.questions;

    if (state.finished) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              score: state.score,
              selectedAnswers: state.selectedAnswers,
              questions: questions,
            ),
          ),
        );
      });
    }

    final question = questions[state.index];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, anim) =>
            SlideTransition(position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(anim), child: child),
        child: Padding(
          key: ValueKey(state.index),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Question ${state.index + 1} of ${questions.length}',
                  style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: (state.index + 1) / questions.length),
              const SizedBox(height: 20),
              Text(question.text,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () => ctrl.answer(i),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(question.options[i]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}