import 'analysis_history.dart';

class HistoryStore {
  static final List<AnalysisEntry> _entries = [];

  static void addEntry(AnalysisEntry entry) {
    _entries.add(entry);
  }

  static List<AnalysisEntry> get entries => _entries;
}
