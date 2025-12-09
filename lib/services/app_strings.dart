import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'language_provider.dart';

/// ########################################################################
/// 🌍 APP STRINGS – CENTRAL LANGUAGE DICTIONARY
/// ########################################################################
///
/// ✅ Single source of truth for ALL texts
/// ✅ Uses Provider’s LanguageController to detect active language
/// ✅ Supports clean key-based translations
/// ✅ Dynamic formatting supported
/// ✅ Future-proof for multi-language expansion
///
/// HOW TO USE:
/// ------------------------------------------------------------------------
///
/// ✅ Simple text:
///     AppStrings.of(context, "appTitle");
///
/// ✅ Dynamic parameters:
///     AppStrings.format(context, "welcome", {"name": userName});
///
/// ########################################################################

class AppStrings {
  // ----------------------------------------------------------------------
  // 🗂 MASTER DICTIONARY (SUPPORTED LANGUAGES MAP)
  // ----------------------------------------------------------------------

  static final Map<String, Map<String, String>> _texts = {
    // ------------------------------------------------------------------
    // 🏷️ APP CORE
    // ------------------------------------------------------------------
    "appTitle": {
      "en": "🌼 Gadag Tourist Places",
      "kn": "🌼 ಗದಗ ಪ್ರವಾಸಿ ತಾಣಗಳು",
    },

    "splashTagline": {
      "en": "Journey of Heritage • Culture • Nature",
      "kn": "ಇತಿಹಾಸ • ಸಂಸ್ಕೃತಿ • ಪ್ರಕೃತಿಯ ಪಯಣ",
    },

    // ------------------------------------------------------------------
    // 📂 DRAWER MENU
    // ------------------------------------------------------------------
    "login": {
      "en": "🔐 Login / Sign In",
      "kn": "🔐 ಲಾಗಿನ್ / ಪ್ರವೇಶಿಸಿ",
    },

    "profile": {
      "en": "👤 My Profile",
      "kn": "👤 ನನ್ನ ಪ್ರೊಫೈಲ್",
    },

    "changeLang": {
      "en": "🌐 Change Language",
      "kn": "🌐 ಭಾಷೆ ಬದಲಾಯಿಸಿ",
    },

    // ------------------------------------------------------------------
    // 🔐 LOGIN
    // ------------------------------------------------------------------
    "loginTitle": {
      "en": "Sign In",
      "kn": "ಪ್ರವೇಶಿಸಿ",
    },

    "loginHint": {
      "en": "Enter your name",
      "kn": "ನಿಮ್ಮ ಹೆಸರನ್ನು ನಮೂದಿಸಿ",
    },

    "loginBtn": {
      "en": "✅ Login",
      "kn": "✅ ಪ್ರವೇಶಿಸಿ",
    },

    "cancel": {
      "en": "Cancel",
      "kn": "ರದ್ದು",
    },

    // ------------------------------------------------------------------
    // 👤 USER / PROFILE
    // ------------------------------------------------------------------
    "guest": {
      "en": "Guest",
      "kn": "ಅತಿಥಿ",
    },

    "welcome": {
      "en": "Welcome {name} 🌺",
      "kn": "ಸ್ವಾಗತ {name} 🌺",
    },

    "logout": {
      "en": "Logout",
      "kn": "ಲಾಗ್ ಔಟ್",
    },

    "loginSuccess": {
      "en": "Welcome {name}! Login successful ✅",
      "kn": "ಸ್ವಾಗತ {name}! ಲಾಗಿನ್ ಯಶಸ್ವಿ ✅",
    },

    // ------------------------------------------------------------------
    // 📍 PLACE SCREEN
    // ------------------------------------------------------------------
    "descriptionTitle": {
      "en": "📜 Description",
      "kn": "📜 ಇತಿಹಾಸ ಮಾಹಿತಿ",
    },

    "photoGallery": {
      "en": "📸 Photo Gallery",
      "kn": "📸 ಚಿತ್ರ ಸಂಗ್ರಹ",
    },

    // ------------------------------------------------------------------
    // 🚀 FEATURES
    // ------------------------------------------------------------------
    "maps": {
      "en": "🗺️ View on Maps",
      "kn": "🗺️ ನಕ್ಷೆ ವೀಕ್ಷಿಸಿ",
    },

    "voice": {
      "en": "🔊 Voice Narration",
      "kn": "🔊 ಧ್ವನಿ ವಿವರಣೆ",
    },

    "fav": {
      "en": "⭐ Add to Favorites",
      "kn": "⭐ ಮೆಚ್ಚಿನವು",
    },

    "slideshow": {
      "en": "🎞️ Slideshow",
      "kn": "🎞️ ಸ್ಲೈಡಶೋ",
    },

    // ------------------------------------------------------------------
    // 🔔 NOTIFICATIONS / SNACKBARS
    // ------------------------------------------------------------------
    "needLogin": {
      "en": "Please login first ❕",
      "kn": "ಮೊದಲು ಲಾಗಿನ್ ಮಾಡಿ ❕",
    },

    "addedToFav": {
      "en": "Added to favorites ⭐",
      "kn": "ಮೆಚ್ಚಿನ ಪಟ್ಟಿಗೆ ಸೇರಿಸಲಾಗಿದೆ ⭐",
    },

    "narrationStart": {
      "en": "Voice narration started 🔊",
      "kn": "ಧ್ವನಿ ವಿವರಣೆ ಪ್ರಾರಂಭವಾಗಿದೆ 🔊",
    },

    "slideshowStart": {
      "en": "Slideshow started 🎞️",
      "kn": "ಸ್ಲೈಡಶೋ ಪ್ರಾರಂಭವಾಗಿದೆ 🎞️",
    },
  };

  // ----------------------------------------------------------------------
  // 🌐 CORE STRING FETCHER
  // ----------------------------------------------------------------------

  /// ✅ Get string using BuildContext + Provider
  static String of(BuildContext context, String key) {
    final isKannada = context.watch<LanguageProvider>().isKannada;

    return _texts[key]?[isKannada ? "kn" : "en"] ?? "❓$key";
  }

  // ----------------------------------------------------------------------
  // 🧩 DYNAMIC FORMATTER
  // ----------------------------------------------------------------------
  ///
  /// Replace placeholders with values:
  ///
  /// Example dictionary entry:
  ///   "welcome": "Welcome {name} 🌺"
  ///
  /// Usage:
  ///   AppStrings.format(context, "welcome", {"name": userName});
  ///
  static String format(
      BuildContext context,
      String key,
      Map<String, String> params,
      ) {
    String text = of(context, key);

    params.forEach((param, value) {
      text = text.replaceAll("{$param}", value);
    });

    return text;
  }
}
