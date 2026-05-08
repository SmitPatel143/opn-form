// lib/models/dashboard_models.dart
// ------------------------------------------------------------
// All data models used across the dashboard.
// Replace the mock data in mock_data.dart with real API calls.
// ------------------------------------------------------------

class PerformanceScore {
  final int completed;
  final int total;
  final int target;

  const PerformanceScore({
    required this.completed,
    required this.total,
    required this.target,
  });

  double get percentage => total == 0 ? 0 : completed / total;
}

class CategoryRow {
  final String name;
  final int completed;
  final int expired;

  const CategoryRow({
    required this.name,
    required this.completed,
    required this.expired,
  });

  int get total => completed + expired;
  double get completedRatio => total == 0 ? 0 : completed / total;
  double get expiredRatio => total == 0 ? 0 : expired / total;
}

class TrainingRow {
  final String name;
  final int completed;
  final int required;
  final double percentage; // 0–100

  const TrainingRow({
    required this.name,
    required this.completed,
    required this.required,
    required this.percentage,
  });
}

class StocksTask {
  final String name;
  final int completed;
  final int competitors;

  const StocksTask({
    required this.name,
    required this.completed,
    required this.competitors,
  });
}

// ---- Segment options ----
enum DashboardSegment { store, me }

// ---- Full dashboard payload ----
class StoreDashboardData {
  final PerformanceScore performance;
  final List<StocksTask> stocksTasks;
  final List<CategoryRow> categories; // Accounts, Stocks, LPA, etc.

  const StoreDashboardData({
    required this.performance,
    required this.stocksTasks,
    required this.categories,
  });
}

class UserDashboardData {
  final PerformanceScore performance;
  final List<TrainingRow> trainings;

  const UserDashboardData({
    required this.performance,
    required this.trainings,
  });
}

class DateRange {
  final DateTime from;
  final DateTime to;

  const DateRange({required this.from, required this.to});

  String get label => '${fmt(from)} - ${fmt(to)}';

  static String fmt(DateTime d) =>
      '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
}
