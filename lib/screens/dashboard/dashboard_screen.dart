// lib/screens/dashboard_screen.dart
// Root screen that hosts the segment control (Store | Me) and
// switches between StoreDashboardContent and UserDashboardContent.

import 'package:flutter/material.dart';
import '../../data/dashborad/mock_data.dart';
import '../../model/dashboard/dashboard_models.dart';
import '../../widget/dashboard/segment_control.dart';
import 'store_dashboard_screen.dart';
import 'user_dashboard_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardSegment _segment = DashboardSegment.store;
  late DateRange _dateRange;

  @override
  void initState() {
    super.initState();
    _dateRange = MockDataService().defaultDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1B3A6B),
      elevation: 0,
      leading: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
      title: const Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        // Segment control in the app bar area (below in toolbar)
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            icon: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: Container(
          color: const Color(0xFF1B3A6B),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            children: [
              DashboardSegmentControl(
                selected: _segment,
                onChanged: (s) => setState(() => _segment = s),
              ),
              const Spacer(),
              // Filter icon
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_segment == DashboardSegment.store) {
      return StoreDashboardContent(
        dateRange: _dateRange,
        onDateRangeChanged: (r) => setState(() => _dateRange = r),
      );
    } else {
      return UserDashboardContent(
        dateRange: _dateRange,
        onDateRangeChanged: (r) => setState(() => _dateRange = r),
      );
    }
  }
}
