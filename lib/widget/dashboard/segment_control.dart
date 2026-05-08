// lib/widgets/segment_control.dart
// Pure Flutter segment control — Store | Me toggle (no external library).

import 'package:flutter/material.dart';
import '../../model/dashboard/dashboard_models.dart';

class DashboardSegmentControl extends StatelessWidget {
  final DashboardSegment selected;
  final ValueChanged<DashboardSegment> onChanged;

  const DashboardSegmentControl({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Tab(
            label: 'Store',
            isSelected: selected == DashboardSegment.store,
            onTap: () => onChanged(DashboardSegment.store),
          ),
          _Tab(
            label: 'Me',
            isSelected: selected == DashboardSegment.me,
            onTap: () => onChanged(DashboardSegment.me),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? const Color(0xFF2D3142)
                : const Color(0xFF9AA0B2),
          ),
        ),
      ),
    );
  }
}
