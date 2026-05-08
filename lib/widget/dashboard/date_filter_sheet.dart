// lib/widgets/date_filter_sheet.dart
// Date filter row + bottom-sheet picker — no external libraries.

import 'package:flutter/material.dart';
import '../../model/dashboard/dashboard_models.dart';

/// Shows a small date-range row that opens a bottom sheet on tap.
class DateFilterRow extends StatelessWidget {
  final DateRange range;
  final ValueChanged<DateRange> onChanged;

  const DateFilterRow({
    super.key,
    required this.range,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDE1EF)),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9AA0B2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                range.label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF2D3142),
                ),
              ),
            ),
            const Icon(Icons.calendar_today_rounded,
                size: 14, color: Color(0xFF9AA0B2)),
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _DatePickerSheet(
        initial: range,
        onApply: (r) {
          Navigator.pop(context);
          onChanged(r);
        },
      ),
    );
  }
}

// ── Bottom Sheet ─────────────────────────────────────────────
class _DatePickerSheet extends StatefulWidget {
  final DateRange initial;
  final ValueChanged<DateRange> onApply;

  const _DatePickerSheet({required this.initial, required this.onApply});

  @override
  State<_DatePickerSheet> createState() => _DatePickerSheetState();
}

class _DatePickerSheetState extends State<_DatePickerSheet> {
  late DateTime _from;
  late DateTime _to;

  @override
  void initState() {
    super.initState();
    _from = widget.initial.from;
    _to = widget.initial.to;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE1EF),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Select Date Range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 20),
          _DatePickerTile(
            label: 'From',
            date: _from,
            onPicked: (d) => setState(() => _from = d),
          ),
          const SizedBox(height: 12),
          _DatePickerTile(
            label: 'To',
            date: _to,
            onPicked: (d) => setState(() => _to = d),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDDE1EF)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Clear',
                      style: TextStyle(color: Color(0xFF9AA0B2))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      widget.onApply(DateRange(from: _from, to: _to)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B3A6B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Apply',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  final String label;
  final DateTime date;
  final ValueChanged<DateTime> onPicked;

  const _DatePickerTile(
      {required this.label, required this.date, required this.onPicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF1B3A6B),
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onPicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDDE1EF)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9AA0B2))),
            const Spacer(),
            Text(
              DateRange.fmt(date),
              style: const TextStyle(fontSize: 12, color: Color(0xFF2D3142)),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_today_rounded,
                size: 14, color: Color(0xFF9AA0B2)),
          ],
        ),
      ),
    );
  }
}
