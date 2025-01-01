import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:system_tray/system_tray.dart';

class SystemTrayManager {
  static final SystemTrayManager instance = SystemTrayManager._internal();
  final SystemTray _systemTray = SystemTray();
  final AppWindow _appWindow = AppWindow();
  bool _isVisible = false;

  SystemTrayManager._internal();

  Future<void> initialize() async {
    await _setupSystemTray();
    await _setupHotKeys();
  }

  Future<void> _setupSystemTray() async {
    String iconPath = Platform.isWindows ? 'assets/app_icon.png' : 'assets/app_icon.png';

    await _systemTray.initSystemTray(
      title: "FocusFlow",
      iconPath: iconPath,
    );

    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(label: 'Show', onClicked: (menuItem) => _showWindow()),
      MenuItemLabel(label: 'Hide', onClicked: (menuItem) => _hideWindow()),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) => _appWindow.close()),
    ]);

    await _systemTray.setContextMenu(menu);

    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? _showWindow() : _systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? _systemTray.popUpContextMenu() : _showWindow();
      }
    });
  }

  Future<void> _setupHotKeys() async {
    await hotKeyManager.unregisterAll();

    HotKey hotKey = HotKey(
      key: PhysicalKeyboardKey.keyQ,
      modifiers: [HotKeyModifier.control],
      scope: HotKeyScope.system,
    );

    await hotKeyManager.register(hotKey, keyDownHandler: (hotKey) {
      _isVisible ? _hideWindow() : _showWindow();
    });
  }

  void _showWindow() {
    _appWindow.show();
    _isVisible = true;
  }

  void _hideWindow() {
    _appWindow.hide();
    _isVisible = false;
  }
}
