import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

////////////////////////////////////////////////////////////
/// 📦 DATA SOURCE
////////////////////////////////////////////////////////////

import '../data/gadag_places_data.dart';

////////////////////////////////////////////////////////////
/// 🌐 LANGUAGE STATE PROVIDER
////////////////////////////////////////////////////////////

import '../services/language_provider.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🌐 UNIVERSAL TRANSLATION HELPER
///
/// Purpose:
/// ---------------------------------------------------------------------------
/// Single-location utility to fetch translated text content for TouristPlace
/// based on the currently selected application language.
///
/// This keeps UI code extremely clean:
///
/// ✅ No "if (isKannada)" scattered across widgets
/// ✅ Prevents repeated provider logic
/// ✅ Makes language switching instant and global
/// ✅ Clean & maintainable design
/// ✅ Safe for both UI AND Audio Service (TTS)
///
///
/// USAGE EXAMPLES:
/// ---------------------------------------------------------------------------
///
/// UI TEXT:
///    Text(Translate.name(context, place));
///    Text(Translate.short(context, place));
///    Text(Translate.desc(context, place));
///
///
/// AUDIO:
///    AudioService().speak(
///        Translate.desc(context, place),
///        context.read<LanguageProvider>().isKannada,
///    );
///
/// /////////////////////////////////////////////////////////////////////////////

class Translate {
  ////////////////////////////////////////////////////////////
  /// 🔤 PLACE NAME
  ///
  /// Auto-selects between:
  ///   • Kannada  → place.nameKN
  ///   • English  → place.nameEN
  ////////////////////////////////////////////////////////////
  static String name(BuildContext context, TouristPlace place) {
    final bool isKannada =
        context.watch<LanguageProvider>().isKannada;

    return isKannada
        ? place.nameKN
        : place.nameEN;
  }

  ////////////////////////////////////////////////////////////
  /// 🏷 SHORT DESCRIPTION
  ///
  /// Short teaser text shown in list views & cards
  ////////////////////////////////////////////////////////////
  static String short(BuildContext context, TouristPlace place) {
    final bool isKannada =
        context.watch<LanguageProvider>().isKannada;

    return isKannada
        ? place.shortKN
        : place.shortEN;
  }

  ////////////////////////////////////////////////////////////
  /// 📖 FULL DESCRIPTION
  ///
  /// Used on:
  ///   • PlaceDetailScreen
  ///   • Audio narration (TTS)
  ////////////////////////////////////////////////////////////
  static String desc(BuildContext context, TouristPlace place) {
    final bool isKannada =
        context.watch<LanguageProvider>().isKannada;

    return isKannada
        ? place.descKN
        : place.descEN;
  }

  ////////////////////////////////////////////////////////////
  /// 🎙️ AUDIO NARRATION SAFE FETCH
  ///
  /// NOTE:
  /// - Works for Flutter TTS
  /// - Can be passed directly to AudioService
  ////////////////////////////////////////////////////////////
  static String speak(BuildContext context, TouristPlace place) {
    return desc(context, place);
  }

  ////////////////////////////////////////////////////////////
  /// 🌍 LANGUAGE STATE ACCESS (UTILITY)
  ///
  /// Helpful for:
  ///   • Switching UI controls
  ///   • AudioService logic
  ///   • Custom buttons & chips
  ////////////////////////////////////////////////////////////
  static bool isKannada(BuildContext context) {
    return context.read<LanguageProvider>().isKannada;
  }

  ////////////////////////////////////////////////////////////
  /// 🔤 DISPLAY LANGUAGE LABEL
  ///
  /// Used in:
  ///   • AppDrawer language button
  ///   • UI headers
  ////////////////////////////////////////////////////////////
  static String languageLabel(BuildContext context) {
    return isKannada(context) ? "ಕನ್ನಡ" : "English";
  }
}
