import 'package:flutter/material.dart';
import 'package:focusflow/pages/base_page.dart';
import 'package:focusflow/pages/dashboard_page/pomodoro_timer/pomodoro_timer.dart';

class DashboardPage extends BasePage {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: PomodoroTimer(),
    );
  }
}
