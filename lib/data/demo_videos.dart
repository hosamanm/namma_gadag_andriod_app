import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/language_provider.dart';
import '../services/voice_narration.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🎬 NAMMA GADAG – VIDEO MASTER DATA SOURCE
///////////////////////////////////////////////////////////////////////////////
///
/// ✅ FEATURES
/// --------------------------------------------------------------------------
/// • 15 Gadag Tourist Place Videos
/// • Kannada + English support
/// • Provider based live language switching
/// • Full narration audio playback per video
/// • Thumbnail image per card
/// • RichText-ready data values
/// • 100% UI-safe (no widget-layer changes needed)
///
/// ✅ DESIGN
/// --------------------------------------------------------------------------
/// All video language selection is automatically adjusted by:
///
///   LanguageProvider.isKannada
///
/// This means your UI can simply use:
///
///   Text(video.getTitle(context))
///   Text(video.getDescription(context))
///
/// Audio narration can be played using:
///
///   await video.playNarration();
///
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/// 🎞️ VIDEO MODEL – SINGLE VIDEO ENTRY
///////////////////////////////////////////////////////////////////////////////
class DemoVideo {

  // --------------------------------------------------------------------------
  // 🏷 TITLES
  // --------------------------------------------------------------------------

  /// Kannada video title (shown when Kannada selected)
  final String titleKN;

  /// English video title (shown when English selected)
  final String titleEN;

  // --------------------------------------------------------------------------
  // 📖 DESCRIPTIONS (LONG TEXT – RichText friendly)
  // --------------------------------------------------------------------------

  /// Kannada descriptive content
  final String descriptionKN;

  /// English descriptive content
  final String descriptionEN;

  // --------------------------------------------------------------------------
  // 🎥 STREAMING VIDEO URL
  // --------------------------------------------------------------------------

  /// Hosted MP4 link
  final String videoUrl;

  // --------------------------------------------------------------------------
  // 🖼 THUMBNAIL IMAGE (LOCAL ASSET)
  // --------------------------------------------------------------------------

  /// Asset image shown in video card preview
  final String thumbnail;

  // --------------------------------------------------------------------------
  // 🔊 VOICE NARRATION AUDIO
  // --------------------------------------------------------------------------

  /// Local narration voice MP3 asset path
  final String narrationAssetPath;

  // --------------------------------------------------------------------------
  // ✅ CONSTRUCTOR
  // --------------------------------------------------------------------------
  const DemoVideo({
    required this.titleKN,
    required this.titleEN,
    required this.descriptionKN,
    required this.descriptionEN,
    required this.videoUrl,
    required this.thumbnail,
    required this.narrationAssetPath,
  });

  // --------------------------------------------------------------------------
  // 🌐 DYNAMIC TITLE RESOLUTION (LANGUAGE SWITCH)
  // --------------------------------------------------------------------------
  String getTitle(BuildContext context) {
    return context.watch<LanguageProvider>().isKannada
        ? titleKN
        : titleEN;
  }

  // --------------------------------------------------------------------------
  // 🌐 DYNAMIC DESCRIPTION RESOLUTION (LANGUAGE SWITCH)
  // --------------------------------------------------------------------------
  String getDescription(BuildContext context) {
    return context.watch<LanguageProvider>().isKannada
        ? descriptionKN
        : descriptionEN;
  }

  // --------------------------------------------------------------------------
  // 🎧 PLAY NARRATION AUDIO
  // --------------------------------------------------------------------------
  Future<void> playNarration() async {
    await VoiceNarration().play(narrationAssetPath);
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🎞️ VIDEO MASTER COLLECTION – ALL 15 GADAG LOCATIONS
///////////////////////////////////////////////////////////////////////////////
final List<DemoVideo> demoVideos = [

/////////////////////////////////////////////////////////////////////////////
  /// 1️⃣ TRIKUTESHWARA TEMPLE
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ತ್ರಿಕೂಟೇಶ್ವರ ದೇವಾಲಯ",
    titleEN: "Trikuteshwara Temple",

    descriptionKN:
    "ತ್ರಿಕೂಟೇಶ್ವರ ದೇವಾಲಯವು ಶಿವ, ಬ್ರಹ್ಮ ಮತ್ತು ಸೂರ್ಯನಿಗೆ ಸಮರ್ಪಿತವಾದ "
        "ಚಾಲುಕ್ಯ ಶಿಲ್ಪಕಲೆಯ ಅದ್ಭುತ ಮಾದರಿಯಾಗಿದೆ.",

    descriptionEN:
    "An extraordinary Chalukyan architectural masterpiece dedicated to "
        "Shiva, Brahma and Surya. Renowned for intricately carved pillars and "
        "finely sculpted ceilings representing Deccan temple excellence.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",

    thumbnail: "assets/images/videos/trikuteshwara.jpg",

    narrationAssetPath: "assets/audio/videos/trikuteshwara.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 2️⃣ DODDA BASAPPA TEMPLE
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ದೊಡ್ಡ ಬಸಪ್ಪ ದೇವಸ್ಥಾನ",
    titleEN: "Dodda Basappa Temple",

    descriptionKN:
    "ನಕ್ಷತ್ರಾಕಾರದ ಚಾಲುಕ್ಯ ದೇವಸ್ಥಾನವು ಅದ್ಭುತ ಕಲ್ಲು ಕೆತ್ತನೆಯ ಮಾದರಿಯಾಗಿದೆ.",

    descriptionEN:
    "Outstanding star-shaped temple famed for geometric precision and "
        "ornamental stone art.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_2mb.mp4",

    thumbnail: "assets/images/videos/dodda_basappa.jpg",

    narrationAssetPath: "assets/audio/videos/dodda_basappa.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 3️⃣ VEERANARAYANA TEMPLE
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ವೀರನಾರಾಯಣ ದೇವಸ್ಥಾನ",
    titleEN: "Veeranarayana Temple",

    descriptionKN:
    "ಕನ್ನಡ ಮಹಾಕವಿ ಕುಮಾರವ್ಯಾಸರು ಮಹಾಭಾರತ ರಚಿಸಿದ ಪವಿತ್ರ ಸ್ಥಾನ.",

    descriptionEN:
    "Historic temple where poet Kumara Vyasa composed his epic Mahabharata.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",

    thumbnail: "assets/images/videos/veeranarayana.jpg",

    narrationAssetPath: "assets/audio/videos/veeranarayana.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 4️⃣ BRAHMA JINALAYA
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಬ್ರಹ್ಮ ಜೈನಾಲಯ",
    titleEN: "Brahma Jinalaya",

    descriptionKN:
    "ಶಾಂತ ವಾತಾವರಣದ ಜೈನ ದೇವಾಲಯವು ಸರಳ ಶಿಲ್ಪಕಲೆಯ ನಿದರ್ಶನವಾಗಿದೆ.",

    descriptionEN:
    "Ancient Jain temple famed for serene architecture and meditation-friendly ambience.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_10mb.mp4",

    thumbnail: "assets/images/videos/jinalaya.jpg",

    narrationAssetPath: "assets/audio/videos/jinalaya.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 5️⃣ PUTTARAJA MATHA
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಪುಟ್ಟರಾಜ ಗವಟಿ ಮಠ",
    titleEN: "Puttaraja Gavati Matha",

    descriptionKN:
    "ಲಿಂಗಾಯತ ಪರಂಪರೆಯ ಪವಿತ್ರ ಮಠ.",

    descriptionEN:
    "Major Lingayat spiritual and cultural center honoring Puttaraja Swamiji.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_20mb.mp4",

    thumbnail: "assets/images/videos/puttaraja_matha.jpg",

    narrationAssetPath: "assets/audio/videos/puttaraja_matha.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 6️⃣ LAKKUNDI
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಲಕ್ಕುಂಡಿ ದೇವಸ್ಥಾನಗಳು",
    titleEN: "Lakkundi Temples",

    descriptionKN:
    "ಚಾಲುಕ್ಯ ಪರಂಪರೆಯ ಮುಕ್ತ ಸಂಗ್ರಹಾಲಯ.",

    descriptionEN:
    "Historic temple town regarded as an open-air Chalukyan museum.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4",

    thumbnail: "assets/images/videos/lakkundi.jpg",

    narrationAssetPath: "assets/audio/videos/lakkundi.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 7️⃣ MAGADI BIRD SANCTUARY
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಮಗಡಿ ಪಕ್ಷಿಧಾಮ",
    titleEN: "Magadi Bird Sanctuary",

    descriptionKN:
    "ಪಕ್ಷಿಪ್ರಿಯರಿಗಾಗಿ ಸ್ವರ್ಗ ಸಮಾನ ಜಲಾಶಯ.",

    descriptionEN:
    "Wetland sanctuary famous for migratory birds and eco walks.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_40mb.mp4",

    thumbnail: "assets/images/videos/magadi.jpg",

    narrationAssetPath: "assets/audio/videos/magadi.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 8️⃣ TIMMAKKA PARK
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಸಾಲುಮರದ ತಿಮ್ಮಕ್ಕ ಉದ್ಯಾನ",
    titleEN: "Timmakka Park",

    descriptionKN:
    "ಪರಿಸರ ಜಾಗೃತಿಯ ಹೆಸರಿನಲ್ಲಿ ನಿರ್ಮಿತ ಪಾರ್ಕ್.",

    descriptionEN:
    "Dedicated eco-park celebrating environmental conservation.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_50mb.mp4",

    thumbnail: "assets/images/videos/timmakka.jpg",

    narrationAssetPath: "assets/audio/videos/timmakka.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 9️⃣ BASAVESHWARA STATUE
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಬಸವೇಶ್ವರ ಮೂರ್ತಿ",
    titleEN: "Basaveshwara Statue",

    descriptionKN:
    "ಬೀಷ್ಮ ಕೆರೆ ದಂಡೆಯ ಬಳಿ ಇರುವ ಭವ್ಯ ಶಿಲ್ಪ.",

    descriptionEN:
    "Iconic statue offering scenic reflections and city views.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_60mb.mp4",

    thumbnail: "assets/images/videos/basava.jpg",

    narrationAssetPath: "assets/audio/videos/basava.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 🔟 MUNDARGI FORT
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಮುಂದರಗಿ ಕೋಟೆ",
    titleEN: "Mundargi Fort",

    descriptionKN:
    "ಗದಗ ರಕ್ಷಣಾತ್ಮಕ ಇತಿಹಾಸದ ಪ್ರತೀಕ.",

    descriptionEN:
    "Medieval watch fort overlooking surrounding countryside.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_70mb.mp4",

    thumbnail: "assets/images/videos/mundargi.jpg",

    narrationAssetPath: "assets/audio/videos/mundargi.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 11️⃣ SHRIMANTHAGADA FORT
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಶ್ರೀಮಂತಗಡ ಕೋಟೆ",
    titleEN: "Shrimanthagada Fort",

    descriptionKN:
    "ಪರ್ವತ ಶಿಖರದ ಮೇಲೆ ಇರುವ ಹಳೆಯ ಕೋಟೆ.",

    descriptionEN:
    "Ancient hilltop fort ideal for trekking and exploration.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_80mb.mp4",

    thumbnail: "assets/images/videos/shrimanthagada.jpg",

    narrationAssetPath: "assets/audio/videos/shrimanthagada.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 12️⃣ GAJENDRAGADA FORT
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಗಜೇಂದ್ರಗಡ ಕೋಟೆ",
    titleEN: "Gajendragada Fort",

    descriptionKN:
    "ಕೋಟೆ ಮತ್ತು ಕಲಕಲೇಶ್ವರ ದೇವಾಲಯದ ಅಪೂರ್ವ ಸಂಗಮ.",

    descriptionEN:
    "Fort crowning Kalakaleshwara temple with sweeping panoramic views.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_90mb.mp4",

    thumbnail: "assets/images/videos/gajendragada.jpg",

    narrationAssetPath: "assets/audio/videos/gajendragada.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 13️⃣ ZOO & PLANETARIUM
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಪ್ರಾಣಿ ಸಂಗ್ರಹಾಲಯ ಮತ್ತು ತಾರಾಲಯ",
    titleEN: "Zoo & Planetarium",

    descriptionKN:
    "ಪ್ರಾಣಿಗಳು ಹಾಗೂ ಆಕಾಶ ವಿಜ್ಞಾನ ಕಲಿಸುವ ಶಿಕ್ಷಣ ಕೇಂದ್ರ.",

    descriptionEN:
    "Family attraction blending wildlife and cosmic learning.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_100mb.mp4",

    thumbnail: "assets/images/videos/zoo.jpg",

    narrationAssetPath: "assets/audio/videos/zoo.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 14️⃣ BADAMI
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಬಾದಾಮಿ ಗುಹೆಗಳು",
    titleEN: "Badami Caves",

    descriptionKN:
    "ಚಾಲುಕ್ಯ ಪುರಾತನ ಗುಹಾ ದೇವಸ್ಥಾನಗಳು.",

    descriptionEN:
    "World-famous sandstone cave temples with rich sculptures.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_110mb.mp4",

    thumbnail: "assets/images/videos/badami.jpg",

    narrationAssetPath: "assets/audio/videos/badami.mp3",
  ),

/////////////////////////////////////////////////////////////////////////////
  /// 15️⃣ BHIMAMBIKA TEMPLE – ITAGI
/////////////////////////////////////////////////////////////////////////////

  DemoVideo(
    titleKN: "ಭೀಮಾಂಬಿಕಾ ದೇವಸ್ಥಾನ – ಇಟಗಿ",
    titleEN: "Bhimambika Temple – Itagi",

    descriptionKN:
    "ಭಕ್ತಿಯ ಜೀವಂತ ಪರಂಪರೆಯನ್ನು ಪ್ರತಿನಿಧಿಸುವ ದೇವಾಲಯ.",

    descriptionEN:
    "Prominent Shakti shrine linked to the Pandava Bhima legends.",

    videoUrl:
    "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_120mb.mp4",

    thumbnail: "assets/images/videos/bhimambika.jpg",

    narrationAssetPath: "assets/audio/videos/bhimambika.mp3",
  ),
];
