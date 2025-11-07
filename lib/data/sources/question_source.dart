import '../models/question_model.dart';

class QuestionSource {
  static List<Question> getQuestions() => const [
        Question(
          text: "What is Flutter?",
          options: ["A bird", "A framework", "A database", "A language"],
          correctIndex: 1,
          explanation: "Flutter — це фреймворк від Google для створення кросплатформних застосунків.",
        ),
        Question(
          text: "Who developed Dart?",
          options: ["Google", "Apple", "Microsoft", "Amazon"],
          correctIndex: 0,
          explanation: "Мову Dart розробила компанія Google.",
        ),
        Question(
          text: "Which widget is immutable?",
          options: ["StatefulWidget", "StatelessWidget", "Container", "TextField"],
          correctIndex: 1,
          explanation: "StatelessWidget не зберігає стан, тому є незмінним (immutable).",
        ),
      ];
}