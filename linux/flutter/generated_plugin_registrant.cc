//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hotkey_manager_linux/hotkey_manager_linux_plugin.h>
#include <system_tray/system_tray_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hotkey_manager_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HotkeyManagerLinuxPlugin");
  hotkey_manager_linux_plugin_register_with_registrar(hotkey_manager_linux_registrar);
  g_autoptr(FlPluginRegistrar) system_tray_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SystemTrayPlugin");
  system_tray_plugin_register_with_registrar(system_tray_registrar);
}
