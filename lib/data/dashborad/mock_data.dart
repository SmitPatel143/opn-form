// lib/data/mock_data.dart
// ------------------------------------------------------------
// MOCK DATA — swap each getter with an API call when ready.
// All methods are async-ready so you just change the body.
// ------------------------------------------------------------


import '../../model/dashboard/dashboard_models.dart';

class MockDataService {
  // ── Store view data ──────────────────────────────────────
  Future<StoreDashboardData> fetchStoreDashboard(DateRange range) async {
    // TODO: replace with → await ApiService.get('/store/dashboard?from=...&to=...')
    await Future.delayed(const Duration(milliseconds: 300)); // simulate network
    return const StoreDashboardData(
      performance: PerformanceScore(completed: 12, total: 60, target: 7),
      stocksTasks: [
        StocksTask(name: 'Daily Audit',      completed: 17070, competitors: 612),
        StocksTask(name: 'Subscription Musing', completed: 11020, competitors: 614),
        StocksTask(name: 'Pending Transfer', completed: 19128, competitors: 616),
        StocksTask(name: 'Repo Isolation',   completed: 19128, competitors: 616),
      ],
      categories: [
        CategoryRow(name: 'Accounts', completed: 14, expired: 300),
        CategoryRow(name: 'Stocks',   completed: 8,  expired: 200),
        CategoryRow(name: 'LPA',      completed: 5,  expired: 122),
        CategoryRow(name: 'Accounts', completed: 14, expired: 300),
      ],
    );
  }

  // ── Store User (Me) view data ────────────────────────────
  Future<UserDashboardData> fetchUserDashboard(DateRange range) async {
    // TODO: replace with → await ApiService.get('/user/dashboard?from=...&to=...')
    await Future.delayed(const Duration(milliseconds: 300));
    return const UserDashboardData(
      performance: PerformanceScore(completed: 12, total: 20, target: 5),
      trainings: [
        TrainingRow(name: 'Thl Training',         completed: 11100, required: 11100, percentage: 90),
        TrainingRow(name: 'Service Excellence',   completed: 11100, required: 11100, percentage: 80),
        TrainingRow(name: 'Skill Check Vitals',   completed: 10090, required: 10090, percentage: 30),
        TrainingRow(name: 'In-store Compliance',  completed: 10090, required: 10090, percentage: 90),
        TrainingRow(name: 'Product Knowledge',    completed: 9500,  required: 10000, percentage: 65),
        TrainingRow(name: 'Safety & Hygiene',     completed: 8800,  required: 10000, percentage: 55),
        TrainingRow(name: 'Customer Handling',    completed: 9200,  required: 10000, percentage: 72),
        TrainingRow(name: 'Visual Merchandising', completed: 7000,  required: 10000, percentage: 40),
      ],
    );
  }

  // ── Default date range ───────────────────────────────────
  DateRange get defaultDateRange => DateRange(
        from: DateTime(2028, 10, 2),
        to: DateTime(2028, 10, 4),
      );
}
