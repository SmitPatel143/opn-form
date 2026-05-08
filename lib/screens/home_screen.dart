import 'package:flutter/material.dart';

import '../state/form/form_renderer.dart';
import 'dashboard/dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
              Tab(icon: Icon(Icons.assignment), text: "Form"),
            ],
          ),
        ),
        // 3. Use TabBarView in the body to render the content
        body: const TabBarView(
          children: [
            DashboardScreen(), // Content for the first tab
            DynamicForm(),     // Content for the second tab
          ],
        ),
      ),
    );
  }
}