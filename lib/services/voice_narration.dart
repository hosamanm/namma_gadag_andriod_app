import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/widgets.dart';

import '../widgets/translate.dart';
import '../data/gadag_places_data.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🎧 VOICE NARRATION SERVICE – COMPLETE & REFINED
///
/// RESPONSIBILITIES:
/// --------------------------------------------------------------------------
/// ✅ Play pre-recorded narration audio (Kannada / English)
/// ✅ Detect active app language using Translate Provider
/// ✅ Fallback to TTS if audio asset is missing
/// ✅ Prevent overlapping audio playback
/// ✅ Provide direct public audio playback for buttons or UI widgets
/// ✅ Safely verify assets before playback
///
/// AUDIO FOLDER STRUCTURE:
///
///   assets/audio/en/trikuteshwara.mp3
///   assets/audio/kn/trikuteshwara.mp3
///   assets/audio/welcome.mp3
///
/// pubspec.yaml must contain:
///
/// flutter:
///   assets:
///     - assets/audio/
///
/// --------------------------------------------------------------------------
///
/// USAGE EXAMPLES:
///
/// ✅ Place Narration:
///   VoiceNarration.instance.speakPlace(context, place);
///
/// ✅ Direct Playback:
///   VoiceNarration.instance.play("audio/welcome.mp3");
///
/// ✅ Stop Audio:
///   VoiceNarration.instance.stop();
///
///////////////////////////////////////////////////////////////////////////////
class VoiceNarration {

  /////////////////////////////////////////////////////////////////////////////
  /// 🔐 SINGLETON
  ///
  /// Ensures only one audio/TTS engine exists for entire app lifetime.
  /////////////////////////////////////////////////////////////////////////////
  static final VoiceNarration instance = VoiceNarration._internal();

  factory VoiceNarration() => instance;

  VoiceNarration._internal();

  /////////////////////////////////////////////////////////////////////////////
  /// 🔌 AUDIO ENGINES
  /////////////////////////////////////////////////////////////////////////////
  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();

  /////////////////////////////////////////////////////////////////////////////
  /// 🎯 MAIN NARRATION METHOD
  ///
  /// WORKFLOW:
  ///
  /// 1️⃣ Identify current language
  /// 2️⃣ Generate localized audio paths
  /// 3️⃣ Try playing audio assets
  /// 4️⃣ On failure → speak text narration via TTS
  /////////////////////////////////////////////////////////////////////////////
  Future<void> speakPlace(BuildContext context, TouristPlace place) async {

    //-------------------------------------------------------
    // Stop anything currently playing
    //-------------------------------------------------------
    await stop();

    //-------------------------------------------------------
    // Detect UI language (Kannada vs English)
    //-------------------------------------------------------
    final bool isKannada = Translate.isKannada(context);

    //-------------------------------------------------------
    // Extract base audio file name from model
    // Example:
    //    assets/audio/voice_place_1.mp3  → voice_place_1.mp3
    //-------------------------------------------------------
    final String basename = _extractBasename(place.voiceFile);

    //-------------------------------------------------------
    // Construct language-specific asset paths
    //-------------------------------------------------------
    final String knPath = "audio/kn/$basename";
    final String enPath = "audio/en/$basename";

    //-------------------------------------------------------
    // Order candidate paths based on selected language
    //-------------------------------------------------------
    final List<String> candidates =
    isKannada ? [knPath, enPath] : [enPath, knPath];

    //-------------------------------------------------------
    // Attempt playback in preferred → fallback order
    //-------------------------------------------------------
    for (final path in candidates) {
      if (await _assetExists(path)) {
        await _playAsset(path);
        return;
      }
    }

    //-------------------------------------------------------
    // No audio found – fallback to TTS narration
    //-------------------------------------------------------
    await _speakWithTts(context, place, isKannada);
  }

  /////////////////////////////////////////////////////////////////////////////
  /// ▶️ PUBLIC DIRECT AUDIO PLAY
  ///
  /// Allows simple playback of audio from buttons/images etc.
  ///
  /// Example:
  ///   VoiceNarration.instance.play("audio/welcome.mp3");
  ///   VoiceNarration.instance.play("assets/audio/welcome.mp3");
  /////////////////////////////////////////////////////////////////////////////
  Future<void> play(String assetPath) async {

    //-------------------------------------------------------
    // Stop any running audio
    //-------------------------------------------------------
    await stop();

    //-------------------------------------------------------
    // Normalize path
    //-------------------------------------------------------
    String path = assetPath.trim();
    if (path.startsWith("assets/")) {
      path = path.replaceFirst("assets/", "");
    }

    //-------------------------------------------------------
    // Verify file exists before playing
    //-------------------------------------------------------
    final bool exists = await _assetExists(path);
    if (!exists) {
      debugPrint("❌ Audio asset missing: assets/$path");
      return;
    }

    //-------------------------------------------------------
    // Start playback
    //-------------------------------------------------------
    await _playAsset(path);
  }

  /////////////////////////////////////////////////////////////////////////////
  /// 🎧 LOW-LEVEL ASSET AUDIO PLAYER
  /////////////////////////////////////////////////////////////////////////////
  Future<void> _playAsset(String assetPath) async {
    await _player.stop();
    await _player.play(AssetSource(assetPath));
  }

  /////////////////////////////////////////////////////////////////////////////
  /// 🗣️ TEXT-TO-SPEECH FALLBACK
  /////////////////////////////////////////////////////////////////////////////
  Future<void> _speakWithTts(
      BuildContext context,
      TouristPlace place,
      bool isKannada,
      ) async {

    //-------------------------------------------------------
    // Grab translated description
    //-------------------------------------------------------
    final String narrationText = Translate.desc(context, place);

    //-------------------------------------------------------
    // Configure TTS engine
    //-------------------------------------------------------
    await _tts.setLanguage(isKannada ? "kn-IN" : "en-IN");
    await _tts.setSpeechRate(0.48);
    await _tts.setPitch(1.0);

    //-------------------------------------------------------
    // Speak narration
    //-------------------------------------------------------
    await _tts.speak(narrationText);
  }

  /////////////////////////////////////////////////////////////////////////////
  /// 🛑 STOP ALL AUDIO
  /////////////////////////////////////////////////////////////////////////////
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (_) {}
    try {
      await _tts.stop();
    } catch (_) {}
  }

  /////////////////////////////////////////////////////////////////////////////
  /// ♻ CLEANUP
  /////////////////////////////////////////////////////////////////////////////
  Future<void> dispose() async {
    await _player.dispose();
    await _tts.stop();
  }

  /////////////////////////////////////////////////////////////////////////////
  /// 🔍 HELPER — EXTRACT MP3 FILENAME
  /////////////////////////////////////////////////////////////////////////////
  String _extractBasename(String path) {
    return path.contains("/") ? path.split("/").last : path;
  }

  /////////////////////////////////////////////////////////////////////////////
  /// 🔎 HELPER — VERIFY ASSET EXISTS
  /////////////////////////////////////////////////////////////////////////////
  Future<bool> _assetExists(String relativePath) async {
    try {
      await rootBundle.load("assets/$relativePath");
      return true;
    } catch (_) {
      return false;
    }
  }
}
