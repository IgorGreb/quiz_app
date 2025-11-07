import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/models/question_model.dart';
import '../../domain/entities/quiz_result.dart';
import '../../core/services/local_storage_service.dart';

final quizRepositoryProvider = Provider((ref) => QuizRepository(LocalStorageService()));

final quizProvider = StateNotifierProvider<QuizController, QuizState>((ref) {
  final repo = ref.watch(quizRepositoryProvider);
  return QuizController(repo);
});

class QuizState {
  final int index;
  final int score;
  final bool finished;
  final List<int> selectedAnswers;

  QuizState({
    this.index = 0,
    this.score = 0,
    this.finished = false,
    this.selectedAnswers = const [],
  });

  QuizState copyWith({
    int? index,
    int? score,
    bool? finished,
    List<int>? selectedAnswers,
  }) {
    return QuizState(
      index: index ?? this.index,
      score: score ?? this.score,
      finished: finished ?? this.finished,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}

class QuizController extends StateNotifier<QuizState> {
  final QuizRepository _repo;
  late final List<Question> _questions;

  QuizController(this._repo) : super(QuizState()) {
    _questions = _repo.getQuestions();
  }

  List<Question> get questions => _questions;

  void answer(int selectedIndex) {
    final question = _questions[state.index];
    final correct = selectedIndex == question.correctIndex;
    final updatedAnswers = [...state.selectedAnswers, selectedIndex];
    final nextIndex = state.index + 1;
    final nextScore = state.score + (correct ? 1 : 0);

    if (nextIndex >= _questions.length) {
      state = state.copyWith(
        finished: true,
        selectedAnswers: updatedAnswers,
        score: nextScore,
      );
      _repo.saveResult(QuizResult(score: nextScore, date: DateTime.now()));
    } else {
      state = state.copyWith(
        index: nextIndex,
        score: nextScore,
        selectedAnswers: updatedAnswers,
      );
    }
  }

  void reset() => state = QuizState();
}