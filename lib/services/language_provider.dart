import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🌐 LANGUAGE PROVIDER – GLOBAL APP LOCALIZATION CONTROLLER
/// ---------------------------------------------------------------------------
///
/// Central state manager for all language behavior across the app.
///
/// 🎯 FEATURES:
/// ✅ English ⇄ Kannada language switching
/// ✅ Live UI refresh using Provider
/// ✅ Tooltip-safe API getters
/// ✅ UI-friendly labels ("English" / "ಕನ್ನಡ")
/// ✅ Locale code exposure ("en" / "kn")
/// ✅ Compatible with audio narration, rich text, and image captions
///
/// ---------------------------------------------------------------------------
///
/// ✅ USAGE EXAMPLES
///
/// 🧠 READ CURRENT STATE
/// ------------------------------------------------
///   context.watch<LanguageProvider>().isKannada
///
/// 🔁 TOGGLE LANGUAGE
/// ------------------------------------------------
///   context.read<LanguageProvider>().toggleLanguage();
///
/// 🎯 FORCE SELECT LANGUAGE
/// ------------------------------------------------
///   context.read<LanguageProvider>().setKannada(true);
///
/// 🏷 UI LABEL
/// ------------------------------------------------
///   lang.currentLanguage
///   lang.currentLanguageLabel
///
/// 🌍 LOCALE CODE (future i18n)
/// ------------------------------------------------
///   lang.languageCode
///
/// ---------------------------------------------------------------------------
///
/// ✅ COMMON ERROR FIXED:
///
/// Older widgets referenced:
///       tooltip: lang.currentLanguage
///
/// Without the getter below, Flutter would throw:
///       "The getter 'currentLanguage' isn't defined"
///
/// This version DEFINES that getter properly ✅
///
/// ---------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////

class LanguageProvider extends ChangeNotifier {

  // ==========================================================================
  // 🔤 PRIVATE STATE
  // ==========================================================================

  /// ✅ true  → Kannada language enabled
  /// ✅ false → English language enabled (default)
  bool _isKannada = false;



  // ==========================================================================
  // 📥 PUBLIC READ-ONLY GETTERS
  // ==========================================================================

  ///----------------------------------------------------------
  /// 🔍 MAIN LANGUAGE FLAG
  ///----------------------------------------------------------
  /// UI widgets observe this value:
  ///
  ///   if (lang.isKannada) => show Kannada
  ///   else                => show English
  ///
  bool get isKannada => _isKannada;


  ///----------------------------------------------------------
  /// 🏷 PRIMARY DISPLAY LABEL
  ///----------------------------------------------------------
  /// Shown in buttons, menu items, drawers etc.
  ///
  /// Example Output:
  ///   "English"
  ///   "ಕನ್ನಡ"
  ///
  String get currentLanguageLabel =>
      _isKannada ? "ಕನ್ನಡ" : "English";


  ///----------------------------------------------------------
  /// ✅ TOOLTIP-SAFE ALIAS GETTER
  ///----------------------------------------------------------
  ///
  /// Your UI currently uses:
  ///     tooltip: lang.currentLanguage
  ///
  /// Without THIS getter:
  ///     ❌ Compile error occurs
  ///
  /// Now this alias ensures:
  ///     ✅ tooltip works
  ///     ✅ compatibility maintained
  ///     ✅ no breaking changes
  ///
  String get currentLanguage => currentLanguageLabel;


  ///----------------------------------------------------------
  /// 🌍 LOCALE CODE
  ///----------------------------------------------------------
  /// Used for future Flutter internationalization support.
  ///
  /// Example:
  ///   "en" → English
  ///   "kn" → Kannada
  ///
  String get languageCode =>
      _isKannada ? "kn" : "en";



  // ==========================================================================
  // 🔁 PUBLIC ACTIONS (STATE MUTATIONS)
  // ==========================================================================

  ///----------------------------------------------------------
  /// 🔄 TOGGLE LANGUAGE
  ///----------------------------------------------------------
  ///
  /// ENGLISH → KANNADA
  /// KANNADA → ENGLISH
  ///
  /// Automatically triggers redraw of:
  ///   • All text widgets
  ///   • Audio buttons
  ///   • Drawer menu labels
  ///   • Rich text descriptions
  ///
  void toggleLanguage() {
    _isKannada = !_isKannada;
    notifyListeners(); // 🚀 Instant UI refresh
  }


  ///----------------------------------------------------------
  /// 🎯 FORCE SET LANGUAGE
  ///----------------------------------------------------------
  ///
  /// Useful for:
  /// ✅ Drop-down selections
  /// ✅ Radio buttons
  /// ✅ Settings screens
  ///
  /// true  → Kannada
  /// false → English
  ///
  void setKannada(bool value) {
    if (_isKannada == value) return; // Prevent waste re-build

    _isKannada = value;
    notifyListeners(); // 🚀 Update UI instantly
  }
}
