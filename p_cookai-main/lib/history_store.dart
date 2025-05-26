import 'analysis_history.dart';

class HistoryStore {
  static final List<AnalysisEntry> _entries = [];

  static void addEntry(AnalysisEntry entry) {
    _entries.insert(0, entry); // Lo más reciente primero
  }

  static List<AnalysisEntry> get entries => _entries;
}
