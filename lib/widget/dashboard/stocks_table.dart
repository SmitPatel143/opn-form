// lib/widgets/stocks_table.dart
// Stocks task table — Name of Tasks | Completed | Competitors

import 'package:flutter/material.dart';
import '../../model/dashboard/dashboard_models.dart';

class StocksTable extends StatelessWidget {
  final List<StocksTask> tasks;

  const StocksTable({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEBEDF2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F6FA),
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              children: const [
                Expanded(child: _HeaderCell('Name of Tasks')),
                SizedBox(width: 60, child: _HeaderCell('Completed')),
                SizedBox(width: 60, child: _HeaderCell('Competitors')),
              ],
            ),
          ),
          // Rows
          ...tasks.asMap().entries.map((e) {
            final isLast = e.key == tasks.length - 1;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFEBEDF2))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e.value.name,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF2D3142)),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '${e.value.completed}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF2D3142)),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '${e.value.competitors}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF2D3142)),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF9AA0B2),
      ),
    );
  }
}
