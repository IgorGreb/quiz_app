import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/quiz_result.dart';

class LocalStorageService {
  static const _key = 'quiz_history';

  Future<void> saveResult(QuizResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final results = prefs.getStringList(_key) ?? [];
    results.add(jsonEncode(result.toJson()));
    await prefs.setStringList(_key, results);
  }

  Future<List<QuizResult>> loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    final results = prefs.getStringList(_key) ?? [];
    return results
        .map((e) => QuizResult.fromJson(jsonDecode(e)))
        .toList()
        .reversed
        .toList();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}