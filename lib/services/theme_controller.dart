import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🎨 THEME CONTROLLER (LIGHT ⇄ DARK MODE MANAGER)
///////////////////////////////////////////////////////////////////////////////
///
/// PURPOSE:
/// ---------------------------------------------------------------------------
/// Controls and persists the application's theme mode.
///
/// ✅ Enables beautiful Light & Dark themes
/// ✅ Notifies UI widgets via Provider on state changes
/// ✅ Saves user preference to device storage
/// ✅ Automatically restores theme on app launch
///
/// ---------------------------------------------------------------------------
///
/// GLOBAL USAGE:
///
/// ▶ Read Theme:
///    context.watch<ThemeController>().isDark
///
/// ▶ Toggle Theme:
///    context.read<ThemeController>().toggleTheme();
///
/// ▶ Force Dark / Light:
///    context.read<ThemeController>().setDark(true); // or false
///
///////////////////////////////////////////////////////////////////////////////

class ThemeController extends ChangeNotifier {
  //##########################################################################
  // 🔐 PRIVATE STATE
  //##########################################################################

  /// 🌗 Current theme mode flag
  ///
  /// true  → Dark theme enabled
  /// false → Light theme enabled (default)
  bool _isDark = false;

  //##########################################################################
  // 📤 PUBLIC GETTER
  //##########################################################################

  /// Read-only theme status for UI widgets
  bool get isDark => _isDark;

  //##########################################################################
  // 🚀 CONSTRUCTOR
  //##########################################################################

  /// Initializes controller and loads saved preference
  ThemeController() {
    _initializeTheme();
  }

  //##########################################################################
  // 🔁 PUBLIC ACTIONS
  //##########################################################################

  /// 🔄 Toggle theme mode
  ///
  /// Switches Light → Dark OR Dark → Light
  /// Applies UI refresh instantly
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    await _saveTheme();
    notifyListeners();
  }

  /// 🎯 Set theme explicitly
  ///
  /// true  → Dark Theme
  /// false → Light Theme
  ///
  /// Avoids unnecessary rebuild calls when value is unchanged
  Future<void> setDark(bool value) async {
    if (_isDark == value) return;

    _isDark = value;
    await _saveTheme();
    notifyListeners();
  }

  //##########################################################################
  // 💾 PERSISTENCE LAYER
  //##########################################################################

  /// ✅ Save theme choice into SharedPreferences
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkTheme", _isDark);
  }

  //##########################################################################
  // 📥 INITIALIZATION
  //##########################################################################

  /// ✅ Loads saved theme on startup
  /// Called automatically by constructor
  Future<void> _initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDark = prefs.getBool('isDarkTheme') ?? false;

    notifyListeners();
  }
}
