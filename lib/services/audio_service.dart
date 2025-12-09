import 'package:flutter_tts/flutter_tts.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🔊 AUDIO SERVICE (TEXT-TO-SPEECH)
///
/// PRIMARY PURPOSE:
/// - Speak any dynamic text
/// - Language auto-switch:
///     ✅ English  -> en-IN
///     ✅ Kannada  -> kn-IN
///
/// USED FOR:
/// - Place description narration
/// - App notifications or guides
///
/// WHY THIS FILE EXISTS:
/// ✅ Central TTS controller
/// ✅ Prevents "AudioService isn't defined" errors
///////////////////////////////////////////////////////////////////////////////
class AudioService {

  final FlutterTts _tts = FlutterTts();

  /// --------------------------------------------------------------------------
  /// 🔊 SPEAK TEXT
  /// --------------------------------------------------------------------------
  ///
  /// [text]       → Content to read aloud
  /// [isKannada]  → If TRUE => Kannada voice
  ///                If FALSE => English voice
  ///
  /// Fully safe with async control.
  ///
  Future<void> speak(String text, bool isKannada) async {

    //--------------------------------------------------------------
    // 🌍 Set TTS Language
    //--------------------------------------------------------------
    await _tts.setLanguage(
      isKannada ? "kn-IN" : "en-IN",
    );

    //--------------------------------------------------------------
    // 🎙️ Voice tuning
    //--------------------------------------------------------------
    await _tts.setSpeechRate(0.45);   // Comfortable narration speed
    await _tts.setPitch(1.0);         // Natural normal tone

    //--------------------------------------------------------------
    // ▶️ Start speaking
    //--------------------------------------------------------------
    await _tts.speak(text);
  }

  /// 🛑 Stop speaking immediately
  Future<void> stop() async {
    await _tts.stop();
  }
}
