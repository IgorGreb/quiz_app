import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/screens/quiz_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 243, 243, 243),
        useMaterial3: true,
      ),
      title: 'Quiz App',
      routes: {'/quiz': (_) => const QuizScreen()},
      home: const QuizScreen(),
    );
  }
}
