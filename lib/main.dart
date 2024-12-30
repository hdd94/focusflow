import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:system_tray/system_tray.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SystemTray systemTray = SystemTray();
  final AppWindow appWindow = AppWindow();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    await _setupHotKey();
    await _setupSystemTray();
  }

  Future<void> _setupHotKey() async {
    // For hot reload, `unregisterAll()` needs to be called.
    await hotKeyManager.unregisterAll();

    HotKey hotKey = HotKey(
      key: PhysicalKeyboardKey.keyQ,
      modifiers: [HotKeyModifier.control],
      scope: HotKeyScope.system,
    );

    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        // Aktion bei Drücken von Control + Q
        debugPrint('Control + Q wurde gedrückt');
        _isVisible ? _hideWindow() : _showWindow();
      },
      // // Only works on macOS.
      // keyUpHandler: (hotKey) {
      //   print('onKeyUp+${hotKey.toJson()}');
      // },
    );
  }

  Future<void> _setupSystemTray() async {
    String path =
        Platform.isWindows ? 'assets/app_icon.ico' : 'assets/app_icon.ico';

    // SystemTray initialisieren
    await systemTray.initSystemTray(
      title: "System Tray App",
      iconPath: path,
    );

    // Erstellen eines Kontextmenüs
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(label: 'Show', onClicked: (menuItem) => _showWindow()),
      MenuItemLabel(label: 'Hide', onClicked: (menuItem) => _hideWindow()),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
    ]);

    // Kontextmenü setzen
    await systemTray.setContextMenu(menu);

    // SystemTray-Ereignisse registrieren
    systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? _showWindow() : systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? systemTray.popUpContextMenu() : _showWindow();
      }
    });
  }

  void _showWindow() {
    appWindow.show();
    setState(() {
      _isVisible = true;
    });
  }

  void _hideWindow() {
    appWindow.hide();
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Hotkey Manager Example")),
        body: Center(child: Text("Drücke Command + N!")),
      ),
    );
  }
}