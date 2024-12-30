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

  @override
  void initState() {
    super.initState();
    _initializeHotKey();
  }

  void _initializeHotKey() async {
    await _setupHotKey();
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
        print('onKeyDown+${hotKey.toJson()}');
      },
      // Only works on macOS.
      keyUpHandler: (hotKey) {
        print('onKeyUp+${hotKey.toJson()}');
      },
    );
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
