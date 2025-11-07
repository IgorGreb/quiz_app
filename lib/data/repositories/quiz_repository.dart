import '../../domain/entities/quiz_result.dart';
import '../../core/services/local_storage_service.dart';
import '../sources/question_source.dart';
import '../models/question_model.dart';

class QuizRepository {
  final LocalStorageService _storage;

  QuizRepository(this._storage);

  List<Question> getQuestions() => QuestionSource.getQuestions();

  Future<void> saveResult(QuizResult result) => _storage.saveResult(result);

  Future<List<QuizResult>> getHistory() => _storage.loadResults();

  Future<void> clearHistory() => _storage.clear();
}