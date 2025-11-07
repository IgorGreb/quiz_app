import 'package:flutter/material.dart';
import '../../core/services/local_storage_service.dart';
import '../../domain/entities/quiz_result.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _storage = LocalStorageService();
  List<QuizResult> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await _storage.loadResults();
    setState(() => _history = res);
  }

  Future<void> _clear() async {
    await _storage.clear();
    setState(() => _history.clear());
  }

  String _format(DateTime date) => DateFormat('dd.MM.yyyy, HH:mm').format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _history.isEmpty
                ? null
                : () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Очистити історію?'),
                        content: const Text('Ця дія видалить усі результати.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Скасувати')),
                          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Очистити')),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await _clear();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Історію очищено ✅')));
                      }
                    }
                  },
          )
        ],
      ),
      body: _history.isEmpty
          ? const Center(child: Text("Історія порожня 🕓"))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, i) {
                final item = _history[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(item.score.toString(), style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text("Score: ${item.score}"),
                  subtitle: Text("Date: ${_format(item.date)}"),
                );
              },
            ),
    );
  }
}