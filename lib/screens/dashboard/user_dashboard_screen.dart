// lib/screens/user_dashboard_screen.dart
// Renders the "Me" segment view with:
//  • Overall Performance donut chart (12/20)
//  • Training progress rows

import 'package:flutter/material.dart';
import '../../data/dashborad/mock_data.dart';
import '../../model/dashboard/dashboard_models.dart';
import '../../widget/dashboard/date_filter_sheet.dart';
import '../../widget/dashboard/donut_chart.dart';
import '../../widget/dashboard/section_card.dart';
import '../../widget/dashboard/training_progress_row.dart';

class UserDashboardContent extends StatefulWidget {
  final DateRange dateRange;
  final ValueChanged<DateRange> onDateRangeChanged;

  const UserDashboardContent({
    super.key,
    required this.dateRange,
    required this.onDateRangeChanged,
  });

  @override
  State<UserDashboardContent> createState() => _UserDashboardContentState();
}

class _UserDashboardContentState extends State<UserDashboardContent> {
  final _service = MockDataService();
  UserDashboardData? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(UserDashboardContent old) {
    super.didUpdateWidget(old);
    if (old.dateRange != widget.dateRange) _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data = await _service.fetchUserDashboard(widget.dateRange);
    if (mounted) setState(() { _data = data; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF00C1A2)));
    }
    final d = _data!;

    return ListView(
      children: [
        const SizedBox(height: 8),

        // ── Date Filter ──────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DateFilterRow(
            range: widget.dateRange,
            onChanged: widget.onDateRangeChanged,
          ),
        ),

        // ── Overall Performance ──────────────────────────
        SectionCard(
          title: 'Overall Performance',
          child: Row(
            children: [
              DonutChart(
                completed: d.performance.completed,
                total: d.performance.total,
                target: d.performance.target,
              ),
            ],
          ),
        ),

        // ── Training rows ────────────────────────────────
        SectionCard(
          title: 'Training',
          child: Column(
            children: d.trainings
                .map((t) => TrainingProgressRow(data: t))
                .toList(),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
