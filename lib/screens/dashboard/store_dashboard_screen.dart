// lib/screens/store_dashboard_screen.dart
// Renders the "Store" segment view with:
//  • Overall Performance donut chart
//  • Stocks task table
//  • Category progress rows (Accounts, Stocks, LPA …)

import 'package:flutter/material.dart';
import '../../data/dashborad/mock_data.dart';
import '../../model/dashboard/dashboard_models.dart';
import '../../widget/dashboard/category_progress_row.dart';
import '../../widget/dashboard/date_filter_sheet.dart';
import '../../widget/dashboard/donut_chart.dart';
import '../../widget/dashboard/section_card.dart';
import '../../widget/dashboard/stocks_table.dart';

class StoreDashboardContent extends StatefulWidget {
  final DateRange dateRange;
  final ValueChanged<DateRange> onDateRangeChanged;

  const StoreDashboardContent({
    super.key,
    required this.dateRange,
    required this.onDateRangeChanged,
  });

  @override
  State<StoreDashboardContent> createState() => _StoreDashboardContentState();
}

class _StoreDashboardContentState extends State<StoreDashboardContent> {
  final _service = MockDataService();
  StoreDashboardData? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(StoreDashboardContent old) {
    super.didUpdateWidget(old);
    if (old.dateRange != widget.dateRange) _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data = await _service.fetchStoreDashboard(widget.dateRange);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DonutChart(
                completed: d.performance.completed,
                total: d.performance.total,
                target: d.performance.target,
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: SizedBox(), // placeholder for legend / extra info
              ),
            ],
          ),
        ),

        // ── Stocks task table ────────────────────────────
        SectionCard(
          title: 'Stocks',
          child: StocksTable(tasks: d.stocksTasks),
        ),

        // ── Category rows ────────────────────────────────
        SectionCard(
          title: 'Accounts',
          child: Column(
            children: d.categories
                .where((c) => c.name == 'Accounts')
                .map((c) => CategoryProgressRow(data: c))
                .toList(),
          ),
        ),

        SectionCard(
          title: 'Stocks',
          child: Column(
            children: d.categories
                .where((c) => c.name == 'Stocks')
                .map((c) => CategoryProgressRow(data: c))
                .toList(),
          ),
        ),

        SectionCard(
          title: 'LPA',
          child: Column(
            children: d.categories
                .where((c) => c.name == 'LPA')
                .map((c) => CategoryProgressRow(data: c))
                .toList(),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
