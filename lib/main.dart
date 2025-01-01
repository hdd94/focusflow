
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisierung des FlutterLocalNotificationsPlugins
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // macOS spezifische Initialisierung
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    macOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
  );

  runApp(MyApp(flutterLocalNotificationsPlugin));
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyApp(this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(flutterLocalNotificationsPlugin),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  HomeScreen(this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Local Notifications (macOS)'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Benachrichtigung auslösen
            _showNotification();
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }

  // Funktion zum Anzeigen einer Benachrichtigung
  Future<void> _showNotification() async {
    const NotificationDetails notificationDetails = NotificationDetails(
      macOS: DarwinNotificationDetails(
        sound: 'default',
        badgeNumber: 1,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID der Benachrichtigung
      'Pomodoro Timer', // Titel
      'Die Pomodoro-Zeit ist abgelaufen!', // Inhalt
      notificationDetails,
      payload: 'timer-ended', // Optional: Zusätzliche Daten
    );
  }
}

// Callback-Funktion bei Klick auf die Benachrichtigung
void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (payload != null) {
    debugPrint('Benachrichtigung Payload: $payload');
  }
  // Navigiere zur entsprechenden Seite oder führe eine andere Aktion aus
  print("Benachrichtigung angeklickt: $payload");
  // Hier könntest du z.B. eine neue Seite aufrufen
}

// import 'package:flutter/material.dart';
// import 'package:focusflow/core/services/system_tray_manager.dart';
// import 'package:focusflow/pages/dashboard_page/dashboard_page.dart';
// import 'package:focusflow/pages/login_page/login_page.dart';
// import 'package:focusflow/pages/settings_page/settings_page.dart';
// import 'package:focusflow/shared/theme/app_theme.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemTrayManager.instance.initialize();
//   runApp(const FocusFlowApp());
// }
//
// class FocusFlowApp extends StatelessWidget {
//   const FocusFlowApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'FocusFlow',
//       theme: AppTheme.theme,
//       initialRoute: '/',
//       routes: {
//         // '/': (context) => LoginPage(),
//         '/': (context) => DashboardPage(),
//         '/dashboard': (context) => const DashboardPage(),
//         '/settings': (context) => const SettingsPage(),
//       },
//     );
//   }
// }