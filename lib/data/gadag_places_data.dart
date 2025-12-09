import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_provider.dart';
import '../services/voice_narration.dart';

//////////////////////////////////////////////////////////////////////////////
// 🏛 TOURIST PLACE MODEL
//////////////////////////////////////////////////////////////////////////////
class TouristPlace {

  final String id;

  // Titles
  final String nameEN;
  final String shortEN;

  final String nameKN;
  final String shortKN;

  // Descriptions
  final String descEN;
  final String descKN;

  // Assets
  final List<String> images;
  final String voiceFile;

  const TouristPlace({
    required this.id,
    required this.nameEN,
    required this.shortEN,
    required this.nameKN,
    required this.shortKN,
    required this.descEN,
    required this.descKN,
    required this.images,
    required this.voiceFile,
  });

  // Language getters
  String title(BuildContext context) =>
      context.watch<LanguageProvider>().isKannada
          ? nameKN
          : nameEN;

  String shortTitle(BuildContext context) =>
      context.watch<LanguageProvider>().isKannada
          ? shortKN
          : shortEN;

  String description(BuildContext context) =>
      context.watch<LanguageProvider>().isKannada
          ? descKN
          : descEN;

  // Play audio narration
  Future<void> playNarration() async {
    await VoiceNarration().play(voiceFile);
  }
}

//////////////////////////////////////////////////////////////////////////////
// Helpers
//////////////////////////////////////////////////////////////////////////////
List<String> _images(int n) =>
    List.generate(6, (i) => "assets/images/places/place$n/${i + 1}.jpg");

String _voice(int n) => "assets/audio/voice_place_$n.mp3";

//////////////////////////////////////////////////////////////////////////////
// 🌍 ALL 15 TOURIST PLACES – FULL ENGLISH + KANNADA
//////////////////////////////////////////////////////////////////////////////

final List<TouristPlace> gadagPlaces = [

//////////////////////////////////////////////////////////////////////////////
// 1️⃣ TRIKUTESHWARA TEMPLE
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_1",
    nameEN: "Trikuteshwara Temple",
    shortEN: "Trikuteshwara",
    nameKN: "ತ್ರಿಕೂಟೇಶ್ವರ ದೇವಸ್ಥಾನ",
    shortKN: "ತ್ರಿಕೂಟೇಶ್ವರ",

    descEN: """
    Trikuteshwara Temple is an extraordinary Chalukyan architectural masterpiece dedicated to the three principal deities Shiva, Brahma, and Surya, making it one of the most spiritually significant monuments in Gadag. The temple is celebrated for its exquisitely carved stone pillars, intricate ceiling patterns, and finely sculpted deities that demonstrate exceptional medieval craftsmanship. Its harmonious layout and artistic finesse reflect the pinnacle of Deccan temple architecture. As a living center of devotion and culture, the temple complex continues to attract pilgrims, historians, and architecture lovers alike, standing proudly as a timeless symbol of Gadag’s rich religious heritage.
""",

    descKN: """
ತ್ರಿಕೂಟೇಶ್ವರ ದೇವಸ್ಥಾನವು ಶಿವ, ಬ್ರಹ್ಮ ಮತ್ತು ಸೂರ್ಯ ಎಂಬ ಮೂರು ಪ್ರಮುಖ ದೇವತೆಗಳಿಗೆ ಅರ್ಪಿತವಾದ ಅದ್ಭುತ ಚಾಲುಕ್ಯ ವಾಸ್ತುಶಿಲ್ಪ ಕೃತಿಯಾಗಿದೆ. ಗದಗ್ ಜಿಲ್ಲೆಯ ಅತ್ಯಂತ ಪವಿತ್ರ ಹಾಗೂ ಮಹತ್ವದ ಐತಿಹಾಸಿಕ ಸ್ಮಾರಕಗಳಲ್ಲಿ ಇದೊಂದು ಪ್ರಮುಖ ಸ್ಥಾನ ಹೊಂದಿದೆ. ಸುಂದರವಾಗಿ ಕೆತ್ತಲಾದ ಕಲ್ಲಿನ ಕಂಬಗಳು, ನಿಭಾಯಿಸಿದ ಮಂಟಪದ ಮೇಲ್ಛಾವಣಿಯ ಅಲಂಕಾರಗಳು ಮತ್ತು ಸೂಕ್ಷ್ಮವಾಗಿ ಕೆತ್ತಲಾದ ದೇವಮೂರ್ತಿಗಳು ಮಧ್ಯಯುಗೀನ ಕುಶಲ ಶಿಲ್ಪಕಲೆಯ ನಿದರ್ಶನವಾಗಿವೆ. ದೇವಸ್ಥಾನದ ಸಮತೋಲನದ ವಿನ್ಯಾಸ ಮತ್ತು ಕಲಾತ್ಮಕ ಸೌಂದರ್ಯವು ದಕ್ಷಿಣ ಭಾರತದ ದೇವಾಲಯ ಶೈಲಿಯ ಶ್ರೇಷ್ಠತೆಯನ್ನು ಪ್ರತಿಬಿಂಬಿಸುತ್ತದೆ. ಭಕ್ತರು, ಇತಿಹಾಸಕಾರರು ಮತ್ತು ಶಿಲ್ಪಕಲಾ ಆಸಕ್ತರನ್ನು ನಿರಂತರವಾಗಿ ಆಕರ್ಷಿಸುವ ಈ ದೇವಸ್ಥಾನವು ಗದಗ್‌ನ ಧಾರ್ಮಿಕ ಪರಂಪರೆಯ ಶಾಶ್ವತ ಸಂಕೇತವಾಗಿದೆ.
""",

    images: _images(1),
    voiceFile: _voice(1),
  ),

//////////////////////////////////////////////////////////////////////////////
// 2️⃣ DODDA BASAPPA TEMPLE
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_2",
    nameEN: "Dambala Dodda Basappa Temple",
    shortEN: "Dodda Basappa",
    nameKN: "ದಂಬಳ ದೊಡ್ಡ ಬಸಪ್ಪ ದೇವಸ್ಥಾನ",
    shortKN: "ದೊಡ್ಡ ಬಸಪ್ಪ",

    descEN: """
The Dodda Basappa Temple is an outstanding example of star-shaped Chalukyan architecture, admired for its geometric precision and artistic ingenuity. The temple features beautifully carved pillars, ornate friezes, and delicately patterned ceilings that display remarkable stone craftsmanship. Every surface tells a story of skilled artistry and refined design from the medieval era. Serving as both a sacred place of worship and an architectural wonder, the temple draws visitors who come to admire not only its spiritual sanctity but also its unique aesthetic brilliance.
""",

    descKN: """
ನಕ್ಷತ್ರಾಕಾರದ ಚಾಲುಕ್ಯ ವಾಸ್ತುಶಿಲ್ಪದ ಅಪೂರ್ವ ಮಾದರಿಯಾಗಿರುವ ದೊಡ್ಡ ಬಸಪ್ಪ ದೇವಸ್ಥಾನವು ತನ್ನ ಜ್ಯಾಮಿತೀಯ ವಿನ್ಯಾಸ ಮತ್ತು ಕಲಾತ್ಮಕ ಕುಶಲತೆಯಿಂದ ಪ್ರಸಿದ್ಧವಾಗಿದೆ. ಚೆನ್ನಾಗಿ ಕೆತ್ತಲಾದ ಕಂಬಗಳು, ಅಲಂಕೃತ ಶಿಲಾವಳಿಗಳು ಮತ್ತು ನಾಜೂಕಾಗಿ ವಿನ್ಯಾಸಗೊಳಿಸಿದ ಮೇಲ್ಛಾವಣಿ ಶಿಲ್ಪಗಳು ಮಧ್ಯಕಾಲೀನ ಶಿಲ್ಪಕಲೆಯ ಉನ್ನತ ಮಟ್ಟವನ್ನು ಪ್ರದರ್ಶಿಸುತ್ತವೆ. ಪ್ರತಿಯೊಂದು ಗೋಡೆಯ ಮೇಲೂ ಶಿಲ್ಪಕಲೆಯ ಕಥೆಯೊಂದು ಜೀವಂತವಾಗಿದೆ. ಭಕ್ತಿಗಾಗಿ ಮಾತ್ರವಲ್ಲದೆ ವಾಸ್ತುಶಿಲ್ಪದ ಸೌಂದರ್ಯ ವೀಕ್ಷಣೆಗೆ ಸಹ ಈ ದೇವಸ್ಥಾನವು ವಿಖ್ಯಾತ ಸ್ಥಳವಾಗಿದೆ.
""",

    images: _images(2),
    voiceFile: _voice(2),
  ),

//////////////////////////////////////////////////////////////////////////////
// 3️⃣ VEERANARAYANA TEMPLE
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_3",
    nameEN: "Veeranarayana Temple",
    shortEN: "Veeranarayana",
    nameKN: "ವೀರನಾರಾಯಣ ದೇವಸ್ಥಾನ",
    shortKN: "ವೀರನಾರಾಯಣ",

    descEN: """
Veeranarayana Temple holds exceptional cultural and literary importance as the sacred site where the legendary Kannada poet Kumara Vyasa composed his epic version of the Mahabharata. Beyond its historical association, the temple itself showcases classic stone architecture characterized by balanced proportions and detailed carvings. Its calm sanctified atmosphere offers a soothing space for both worship and reflection. Admired by literature scholars and devotees alike, this temple stands as a bridge between Karnataka’s literary legacy and spiritual tradition.
""",

    descKN: """
ಕನ್ನಡದ ಮಹಾಕವಿ ಕುಮಾರವ್ಯಾಸರು ತಮ್ಮ ಪ್ರಸಿದ್ಧ ಮಹಾಭಾರತ ಕಾವ್ಯವನ್ನು ರಚಿಸಿದ ಪವಿತ್ರ ಸ್ಥಳವೆಂದು ಹೆಸರುವಾಸಿಯಾದ ವೀರನಾರಾಯಣ ದೇವಸ್ಥಾನವು ಸಾಹಿತ್ಯ ಹಾಗೂ ಸಾಂಸ್ಕೃತಿಕ ಮಹತ್ವವುಳ್ಳ ದೇವಾಲಯವಾಗಿದೆ. ಸಮತೋಲನದ ವಿನ್ಯಾಸ ಮತ್ತು ಸುಂದರ ಶಿಲ್ಪಗಳಿಂದ ಅಲಂಕರಿತವಾದ ಈ ದೇವಸ್ಥಾನವು ಶಿಲ್ಪಕಲೆಯ ಕ್ಲಾಸಿಕ್ ಮಾದರಿಯಾಗಿದೆ. ಶಾಂತಿಯುತ ವಾತಾವರಣವು ಭಕ್ತರಿಗೆ ಮನಸ್ಸಿನ ನೆಮ್ಮದು ನೀಡುತ್ತದೆ. ಸಾಹಿತ್ಯ ಆಸಕ್ತರು ಮತ್ತು ಭಕ್ತರನ್ನು ಒಂದೇ ವೇದಿಕೆಯ ಮೇಲೆ ಸೇರುವಂತೆ ಮಾಡುವ ಈ ದೇವಾಲಯವು ಕರ್ನಾಟಕದ ಸಾಹಿತ್ಯ ಹಾಗೂ ಧಾರ್ಮಿಕ ಪರಂಪರೆಯನ್ನು ಸಂಪರ್ಕಿಸುವ ಸೇತುವೆಯಾಗಿದೆ.
""",

    images: _images(3),
    voiceFile: _voice(3),
  ),

//////////////////////////////////////////////////////////////////////////////
// 4️⃣ BRAHMA JINALAYA
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_4",
    nameEN: "Brahma Jinalaya",
    shortEN: "Jinalaya",
    nameKN: "ಬ್ರಹ್ಮ ಜೈನಾಲಯ",
    shortKN: "ಜೈನಾಲಯ",

    descEN: """
Brahma Jinalaya is an ancient Jain temple distinguished by its elegant stone columns, symmetrical layout, and graceful carvings that embody Jain artistic traditions. The temple’s serene environment makes it an ideal place for quiet contemplation and meditation. As a preserved archaeological monument, it provides valuable evidence of the Jain community’s historical influence in the Gadag region. Its architectural purity and peaceful ambiance continue to attract both spiritual seekers and heritage enthusiasts.
""",

    descKN: """
ಬ್ರಹ್ಮ ಜೈನಾಲಯವು ಜೈನ ಧರ್ಮ ಶಿಲ್ಪಪರಂಪರೆಯನ್ನು ಪ್ರತಿಬಿಂಬಿಸುವ ಸುಂದರ ಕಲ್ಲಿನ ಕಂಬಗಳು, ಸಮಮಿತಿಯ ವಿನ್ಯಾಸ ಮತ್ತು কোমಲ ಶಿಲ್ಪಗಳಿಂದ ವಿಶಿಷ್ಟವಾಗಿ ಹೊರಹೊಮ್ಮಿದೆ. ಶಾಂತ ವಾತಾವರಣವು ಧ್ಯಾನ ಮತ್ತು ಆತ್ಮಪರಿಶೀಲನೆಗೆ ವಿಶೇಷ ಅನುಕೂಲವಾಗಿದೆ. ಪುರಾತತ್ವ ಮಹತ್ವದ ಸ್ಮಾರಕವಾಗಿರುವ ಈ ಜೈನಾಲಯವು ಗದಗ್ ಪ್ರದೇಶದಲ್ಲಿ ಜೈನ ಸಮುದಾಯದ ಐತಿಹಾಸಿಕ ಪಾತ್ರವನ್ನು ಸ್ಪಷ್ಟವಾಗಿ ತಿಳಿಸುತ್ತದೆ.
""",

    images: _images(4),
    voiceFile: _voice(4),
  ),

//////////////////////////////////////////////////////////////////////////////
// 5️⃣ PUTTARAJA MATHA
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_5",
    nameEN: "Shri Puttaraja Gavati Matha",
    shortEN: "Puttaraja Matha",
    nameKN: "ಶ್ರೀ ಪುಟ್ಟರಾಜ ಗವಟಿ ಮಠ",
    shortKN: "ಪುಟ್ಟರಾಜ ಮಠ",

    descEN: """
Shri Puttaraja Gavati Matha is a prominent spiritual institution dedicated to the revered Lingayat saint Puttaraja Swamiji, who is greatly respected for his philosophical teachings and contributions to religious education. The Matha thrives as a vibrant center of prayer, learning, and devotion, hosting daily rituals, cultural gatherings, and community services. Pilgrims from across Karnataka visit to seek blessings and spiritual guidance. The serene atmosphere and devotional energy of the Matha make it a meaningful destination for those exploring firsthand experiences of living religious traditions.
""",

    descKN: """
ಲಿಂಗಾಯತ ಸಂತರಾದ ಶ್ರೀ ಪುಟ್ಟರಾಜ ಸ್ವಾಮೀಜಿಯವರ ಸ್ಮರಣಾರ್ಥ ಸ್ಥಾಪಿತವಾದ ಈ ಮಠವು ಪ್ರಾರ್ಥನೆ, ಅಧ್ಯಯನ ಹಾಗೂ ಧಾರ್ಮಿಕ ಚಟುವಟಿಕೆಗಳ ಪ್ರಮುಖ ಕೇಂದ್ರವಾಗಿದೆ. ದಿನವೂ ಪೂಜೆಗಳು, ಸಾಂಸ್ಕೃತಿಕ ಕಾರ್ಯಕ್ರಮಗಳು ಮತ್ತು ಸೇವಾ ಕಾರ್ಯಗಳು ಇಲ್ಲಿ ನಡೆಯುತ್ತವೆ. ಕರ್ನಾಟಕದ ವಿವಿಧ ಭಾಗಗಳಿಂದ ಭಕ್ತರು ಆಶೀರ್ವಾದಕ್ಕಾಗಿ ಭೇಟಿ ನೀಡುತ್ತಾರೆ. ಮಠದ ಶಾಂತ ವಾತಾವರಣವು ಆತ್ಮಶಾಂತಿಯ ಅನುಭವವನ್ನು ಕೊಡುವ ಅತ್ಯುತ್ತಮ ಸ್ಥಳವಾಗಿದೆ.
""",

    images: _images(5),
    voiceFile: _voice(5),
  ),

//////////////////////////////////////////////////////////////////////////////
// 6️⃣ LAKKUNDI
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_6",
    nameEN: "Lakkundi",
    shortEN: "Lakkundi Temples",
    nameKN: "ಲಕ್ಕುಂಡಿ",
    shortKN: "ಲಕ್ಕುಂಡಿ ದೇವಾಲಯಗಳು",

    descEN: """
Lakkundi is a historic temple village often described as an open-air museum of Chalukyan art and architecture. The settlement contains dozens of remarkably preserved shrines, stepped water tanks, and ancient stone monuments, including the celebrated Kashi Vishveshwara Temple. Visitors strolling through its quiet lanes encounter visually rich carvings and architectural forms that vividly showcase medieval craftsmanship. Lakkundi offers an immersive journey into Karnataka’s temple-building heritage, providing a rare opportunity to experience history intact in a rural landscape.
""",

    descKN: """
ಲಕ್ಕುಂಡಿ ಗ್ರಾಮವು ಚಾಲುಕ್ಯ ವಾಸ್ತುಶಿಲ್ಪದ ಮುಕ್ತ ಗಾಳಿಯ ಮ್ಯೂಸಿಯಂ ಎಂದು ಖ್ಯಾತವಾಗಿದೆ. ಅನೇಕ ಪುರಾತನ ದೇವಸ್ಥಾನಗಳು, ಹಳ್ಳಿಗಳು (ಕುಣಿಗಳು) ಹಾಗೂ ಕಾಶಿ ವಿಶ್ವೇಶ್ವರ ದೇವಸ್ಥಾನ ಸೇರಿದಂತೆ ಹಲವಾರು ಸ್ಮಾರಕಗಳು ಇಲ್ಲಿದೆ. ಗ್ರಾಮದಲ್ಲಿ ನಡೆದುಹೋಗುವಾಗ ಮಧ್ಯಯುಗೀನ ಶಿಲ್ಪಕಲೆಯ ಜೀವಂತ ರೂಪಗಳನ್ನು ನೇರವಾಗಿ ಅನುಭವಿಸಬಹುದು.
""",

    images: _images(6),
    voiceFile: _voice(6),
  ),

//////////////////////////////////////////////////////////////////////////////
// 7️⃣ MAGADI BIRD SANCTUARY
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_7",
    nameEN: "Magadi Bird Sanctuary",
    shortEN: "Magadi Birds",
    nameKN: "ಮಾಗಡಿ ಪಕ್ಷಿಧಾಮ",
    shortKN: "ಮಾಗಡಿ ಪಕ್ಷಿಗಳು",

    descEN: """
Magadi Bird Sanctuary is a peaceful natural haven that shelters a wide variety of migratory and resident bird species, especially during the winter months when flocks arrive from distant regions. The scenic wetlands, framed by greenery and calm waters, provide ideal conditions for birdwatching, nature photography, and leisurely eco-walks. The sanctuary is treasured by wildlife lovers for its tranquil atmosphere and biodiversity. It also plays a vital role in the conservation of local bird habitats.
""",

    descKN: """
ಮಾಗಡಿ ಪಕ್ಷಿಧಾಮವು ಚಳಿಗಾಲದಲ್ಲಿ ವಲಸೆ ಬರುವ ಹಲವಾರು ಪಕ್ಷಿಗಳನ್ನು ಸೇರಿದಂತೆ ವಿವಿಧ ಜಾತಿಯ ಪಕ್ಷಿಗಳಿಗೆ ಆಶ್ರಯ ನೀಡುವ ಪ್ರಕೃತಿ ಸಂರಕ್ಷಣಾ ಕೇಂದ್ರವಾಗಿದೆ. ಹಸಿರು ನೆಲಸಿರಿಗಳು ಮತ್ತು ಸರೋವರಗಳ ಮಧ್ಯದಲ್ಲಿರುವ ಈ ಪ್ರದೇಶವು ಪಕ್ಷಿವೀಕ್ಷಣೆ, ಫೋಟೋಗ್ರಫಿ ಮತ್ತು ಪ್ರಕೃತಿ ಸಂಚಾರಕ್ಕೆ ಸೂಕ್ತವಾಗಿದೆ.
""",

    images: _images(7),
    voiceFile: _voice(7),
  ),

//////////////////////////////////////////////////////////////////////////////
// 8️⃣ TIMMAKKA PARK
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_8",
    nameEN: "Salumarada Timmakka Park",
    shortEN: "Timmakka Park",
    nameKN: "ಸಾಲುಮರದ ತಿಮ್ಮಕ್ಕ ಉದ್ಯಾನವನ",
    shortKN: "ತಿಮ್ಮಕ್ಕ ಉದ್ಯಾನವನ",

    descEN: """
Named to honor legendary environmental activist Salumarada Thimmakka, this beautifully maintained park symbolizes dedication to environmental conservation and community well-being. The park features landscaped gardens, peaceful walking paths, children’s play areas, and shaded seating zones ideal for family outings. Visitors enjoy leisurely picnics, exercise routines, and moments of relaxation amid its fresh greenery. The park stands as a living tribute to eco-awareness while serving as one of Gadag city’s most refreshing recreational spaces.
""",

    descKN: """
 ಪರಿಸರ ತಾಯಿ ಸಾಲುಮರದ ತಿಮ್ಮಕ್ಕ ಅವರ ಗೌರವಾರ್ಥ ನಿರ್ಮಿಸಲಾದ ಉದ್ಯಾನವು ಹಸಿರು ತೋಟಗಳು, ನಡಿಗೆ ಮಾರ್ಗಗಳು, ಆಟದ ಮೈದಾನಗಳು ಮತ್ತು ವಿಶ್ರಾಂತಿ ಸ್ಥಳಗಳಿಂದ ತುಂಬಿದೆ. ಕುಟುಂಬ ಸಮೇತ ಭೇಟಿ ನೀಡಲು ಇದು ಅದ್ಭುತ ತಾಣವಾಗಿದೆ. ಪರಿಸರ ಸಂರಕ್ಷಣೆಯ ಜಾಗೃತಿಯ ಸಂಕೇತವಾಗಿರುವ ಈ ಉದ್ಯಾನವು ಗದಗ್ ನಗರದ ಪ್ರಮುಖ ವಿನೋದ ಪ್ರదేశಗಳಲ್ಲಿ ಒಂದಾಗಿದೆ.
""",

    images: _images(8),
    voiceFile: _voice(8),
  ),

//////////////////////////////////////////////////////////////////////////////
// 9️⃣ BASAVESHWARA STATUE
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_9",
    nameEN: "Basaveshwar Statue",
    shortEN: "Basaveshwara",
    nameKN: "ಬಸವೇಶ್ವರ ಪ್ರತಿಮೆ",
    shortKN: "ಬಸವೇಶ್ವರ ಮೂರ್ತಿ",

    descEN: """
The majestic statue of Basaveshwara, overlooking the picturesque Bhishma Kere Lake, is one of Gadag’s most iconic landmarks. Set within a landscaped garden complex, the statue pays tribute to the social reformer and philosopher known for promoting equality and spiritual harmony. The peaceful lakeside atmosphere makes the site a favorite for visitors seeking quiet reflection, evening walks, and scenic photography. It gracefully blends spiritual symbolism with natural beauty.
""",

    descKN: """
ಭೀಷ್ಮ ಕೆರೆಯ ಸರೋವರದ ಬಳಿ ಇರುವ ಭವ್ಯ ಬಸವೇಶ್ವರ ಪ್ರತಿಮೆ ಗದಗ್‌ನ ಅತ್ಯಂತ ಪ್ರಸಿದ್ಧ ಗುರುತುಚಿಹ್ನೆಯಾಗಿದೆ. ಸಮಾನತೆ, ಮಾನವೀಯತೆ ಹಾಗೂ ಧಾರ್ಮಿಕ ಸೌಹಾರ್ದತೆಯ ಸಂದೇಶ ನೀಡಿದ ಮಹಾನ್ ಸಮಾಜಸुधಾರಕ ಬಸವೇಶ್ವರರಿಗೆ ಸಲ್ಲಿಸಿದ ಗೌರವವಾಗಿದೆ. ಶಾಂತ ವಾತಾವರಣ, ಸಂಜೆ ನಡಿಗೆ ಮತ್ತು ಫೋಟೋಗ್ರಫಿಗೆ ಇದು ಅತ್ಯುತ್ತಮ ಸ್ಥಳವಾಗಿದೆ.
""",

    images: _images(9),
    voiceFile: _voice(9),
  ),

//////////////////////////////////////////////////////////////////////////////
// 10️⃣ MUNDARGI FORT
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_10",
    nameEN: "Mundargi Fort",
    shortEN: "Mundargi Fort",
    nameKN: "ಮುಂಡರಗಿ ಕೋಟೆ",
    shortKN: "ಮುಂಡರಗಿ ಕೋಟೆ",

    descEN: """
Mundargi Fort stands as a historic sentinel of Gadag’s defensive past. Built with sturdy stone walls and elevated ramparts, the fort once served as a strategic watchpost guarding the surrounding countryside. Though partially weathered by time, its broad viewpoints still offer sweeping landscapes that captivate visitors. For history enthusiasts, the fort narrates tales of regional warfare, territorial defense, and medieval governance.
""",

    descKN: """
ಮುಂಡರಗಿ ಕೋಟೆ ಗದಗ್ ಜಿಲ್ಲೆಯ ರಕ್ಷಣಾತ್ಮಕ ಇತಿಹಾಸದ ಮೌನ ಸಾಕ್ಷಿಯಾಗಿದೆ. ದಪ್ಪ ಕಲ್ಲುಗೋಡೆಗಳು ಮತ್ತು ಎತ್ತರದ ಅಡಿಪಾಯಗಳು ಕೋಟೆಯ ವೈಭವವನ್ನು ಸೂಚಿಸುತ್ತವೆ. ಇಂದು ಅರ್ಧ ಕುರುಡು ಸ್ಥಿತಿಯಲ್ಲಿದ್ದರೂ ಮೇಲ್ಭಾಗದಿಂದ ಕಾಣುವ ಭೂದೃಶ್ಯ ಮನಮೋಹಕವಾಗಿದೆ.
""",

    images: _images(10),
    voiceFile: _voice(10),
  ),

//////////////////////////////////////////////////////////////////////////////
// 11️⃣ SHRIMANTAGHADA
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_11",
    nameEN: "Shrimantaghada Fort",
    shortEN: "Shrimantaghada",
    nameKN: "ಶ್ರೀಮಂತಗಡ ಕೋಟೆ",
    shortKN: "ಶ್ರೀಮಂತಗಡ",

    descEN: """
Shrimantaghada Fort is an ancient rocky stronghold known for its rugged stone foundations and commanding panoramic views. Despite its present state of partial ruins, the fort impresses visitors with its scale and remote hilltop location. It remains an adventurous exploration site for heritage enthusiasts and trekkers interested in Karnataka’s medieval defenses. The fort silently preserves stories of battles, guardianship, and bygone military engineering.
""",

    descKN: """
ಶ್ರೀಮಂತಗಡ ಕೋಟೆ ಬಂಡೆಯ ಮೇಲೆ ನಿರ್ಮಿಸಲಾದ ಪುರಾತನ ಕೋಟೆಯಾಗಿದ್ದು ತನ್ನ ವಿಶಾಲ ದೃಶ್ಯಾವಳಿಯಿಂದ ಪ್ರಸಿದ್ಧವಾಗಿದೆ. ಇಂದು ಅವಶೇಷಗಳ ರೂಪದಲ್ಲಿದ್ದರೂ ಐತಿಹಾಸಿಕ ಸಂಶೋಧಕರು ಮತ್ತು ಟ್ರೆಕ್ಕಿಂಗ್ ಪ್ರಿಯರಿಗೆ ಇದು ಆಕರ್ಷಕ ಸ್ಥಳವಾಗಿದೆ.
""",

    images: _images(11),
    voiceFile: _voice(11),
  ),

//////////////////////////////////////////////////////////////////////////////
// 12️⃣ GAJENDRAGADA
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_12",
    nameEN: "Gajendragada Fort & Kalakaleshwara Temple",
    shortEN: "Gajendragada",
    nameKN: "ಗಜೇಂದ್ರಗಡ ಕೋಟೆ ಮತ್ತು ಕಾಲಕಾಲೇಶ್ವರ ದೇವಸ್ಥಾನ",
    shortKN: "ಗಜೇಂದ್ರಗಡ",

    descEN: """
The hilltop Gajendragada Fort, crowned by the sacred Kalakaleshwara Temple, beautifully combines Karnataka’s military history with devotional tradition. Visitors climb ancient stone pathways winding through formidable fort walls to reach the summit shrine. From the temple, sweeping panoramic views unfold across the surrounding plains. The spiritual experience of visiting the temple blends seamlessly with the scenic adventure of exploring the fort, making the site both uplifting and visually rewarding.
""",

    descKN: """
ಬೆಟ್ಟದ ಮೇಲಿರುವ ಗಜೇಂದ್ರಗಡ ಕೋಟೆ ಮತ್ತು ಅದರ ಮಸ್ತಕದಲ್ಲಿ ನೆಲೆಗೊಂಡಿರುವ ಕಾಲಕಾಲೇಶ್ವರ ದೇವಸ್ಥಾನವು ಧಾರ್ಮಿಕತೆ ಮತ್ತು ಸಾಹಸವನ್ನು ಒಟ್ಟುಗೂಡಿಸುವ ಸ್ಥಳವಾಗಿದೆ. ಸಂಕೀರ್ಣ ಪಥಗಳಿಂದ ಮೇಲೇರಿದಾಗ ದೇವಾಲಯದ ಬಳಿ ಬಿಸಿಲುಗಾಡಿನ ವಿಶಾಲ ನೋಟ ಲಭ್ಯವಾಗುತ್ತದೆ.
""",

    images: _images(12),
    voiceFile: _voice(12),
  ),

//////////////////////////////////////////////////////////////////////////////
// 13️⃣ ZOO & PLANETARIUM
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_13",
    nameEN: "Gadag Zoo & Planetarium",
    shortEN: "Zoo & Planetarium",
    nameKN: "ಗದಗ ಮೃಗಾಲಯ ಹಾಗೂ ತಾರಾಲಯ",
    shortKN: "ಮೃಗಾಲಯ ಮತ್ತು ತಾರಾಲಯ",

    descEN: """
This educational complex brings together wildlife observation and astronomical learning in one engaging destination. Visitors can explore zoo enclosures featuring diverse animal species before attending immersive star shows inside the planetarium that showcase cosmic wonders. The facility is particularly popular with school groups and families, offering interactive experiences that blend entertainment with education. It remains one of Gadag’s top family attractions.
""",

    descKN: """
ವಿವಿಧ ಪ್ರಾಣಿಗಳನ್ನು ವೀಕ್ಷಿಸಲು ಅವಕಾಶ ನೀಡುವ ಮೃಗಾಲಯ ಮತ್ತು ನಕ್ಷತ್ರಮಂಡಲ ಜ್ಞಾನ ನೀಡುವ ಪ್ಲಾನೆಟೇರಿಯಂ ಒಂದೇ ಸಂಕೀರ್ಣದಲ್ಲಿದ್ದು, ಮಕ್ಕಳಿಗೂ ಕುಟುಂಬಗಳಿಗೂ ಅತ್ಯಂತ ಮೆಚ್ಚಿನ ಪ್ರವಾಸಿ ತಾಣವಾಗಿದೆ.
""",

    images: _images(13),
    voiceFile: _voice(13),
  ),

//////////////////////////////////////////////////////////////////////////////
// 14️⃣ BADAMI
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_14",
    nameEN: "Badami",
    shortEN: "Badami Caves",
    nameKN: "ಬಾದಾಮಿ ಗುಹೆಗಳು",
    shortKN: "ಬಾದಾಮಿ",

    descEN: """
Badami is a world-renowned heritage town famous for its spectacular rock-cut cave temples carved into vibrant red sandstone cliffs overlooking a serene water reservoir. The caves preserve magnificent Hindu and Jain sculptures along with ancient murals and decorative panels. Each chamber reflects refined craftsmanship and artistic storytelling dating back to the Chalukya era. Badami remains a must-visit destination for anyone passionate about ancient Indian art and architecture.
""",

    descKN: """
ಕೆಂಪು ಮಣ್ಣಿನ ಕಲ್ಲುಗಳಲ್ಲಿ ಕೆತ್ತಿ ನಿರ್ಮಿಸಲಾದ ಬಾದಾಮಿ ಗುಹಾ ದೇವಸ್ಥಾನಗಳು ವಿಶ್ವವಿಖ್ಯಾತವಾಗಿದ್ದು, ಹಿಂದೂ ಹಾಗೂ ಜೈನ ಶಿಲ್ಪಗಳ ಅಸಾಧಾರಣ ರೂಪಗಳನ್ನು ಹೊಂದಿವೆ. ಚಾಲುಕ್ಯ ಯುಗದ ಶಿಲ್ಪಕಲೆ ಇಲ್ಲಿ ಜೀವಂತವಾಗಿದೆ.
""",

    images: _images(14),
    voiceFile: _voice(14),
  ),

//////////////////////////////////////////////////////////////////////////////
// 15️⃣ BHIMAMBIKA TEMPLE
//////////////////////////////////////////////////////////////////////////////
  TouristPlace(
    id: "place_15",
    nameEN: "Bhimambika Temple – Itagi",
    shortEN: "Bhimambika Temple",
    nameKN: "ಶ್ರೀ ಭೀಮಾಂಬಿಕಾ ದೇವಸ್ಥಾನ (ಭೀಮವ್ವ) – ಇಟಗಿ",
    shortKN: "ಭೀಮಾಂಬಿಕಾ ದೇವಸ್ಥಾನ",

    descEN: """
The Bhimambika Temple, popularly called Bheemavva Temple, is a prominent spiritual center situated in the historic temple town of Itagi, in Rona Taluk of Gadag District, Karnataka, approximately 13 km from the famous Gajendragad Kalkaleshwara Temple. Dedicated to Goddess Bhimambika, a local manifestation of Shakti (the Divine Mother), the temple holds immense devotional importance for the surrounding communities.

According to regional legends, the temple is closely associated with Bheema, the mighty Pandava prince from the Mahabharata. The goddess is believed to be connected to Bheema’s stories and is revered as a powerful protector deity, inspiring the name Bhimambika or Bhimavva. Over generations, these legends have strengthened the temple’s spiritual identity, even though its history is based more on oral traditions and continuous local worship than on monumental architectural records.

Unlike the nearby Itagi Mahadeva Temple (built in 1112 CE during the Chalukya period) — celebrated for its grand stone architecture — the Bhimambika Temple stands as a symbol of folk devotion and living religious heritage. The temple remains a vibrant place of daily worship, where devotees gather to seek blessings for health, success, family harmony, and fulfillment of vows.

Festivals and special rituals draw large numbers of pilgrims from across the Gadag region and neighboring districts, reinforcing the temple’s role as a center of faith, cultural identity, and community bonding. The serene village surroundings add to the peaceful spiritual atmosphere, making Bhimambika Temple a meaningful stop for pilgrims exploring the rich sacred landscapes of North Karnataka.
""",

    descKN: """
ಇಟಗಿ ಪಟ್ಟಣದಲ್ಲಿ ಇರುವ ಭೀಮಾಂಬಿಕಾ ದೇವಸ್ಥಾನವು ಶಕ್ತಿದೇವಿಯ ಸ್ಥಳೀಯ ರೂಪಕ್ಕೆ ಅರ್ಪಿತವಾಗಿದ್ದು, ಗದಗ್ ಜಿಲ್ಲೆಯ ಪ್ರಮುಖ ಭಕ್ತಿಕಾ ಕೇಂದ್ರವಾಗಿದೆ. ಮಹಾಭಾರತದ ಭೀಮನ ಗೆ ಸಂಬಂಧಿಸಿದ ಸ್ಥಳೀಯ ದಂತಕಥೆಗಳಿಂದ ದೇವಿಗೆ “ಭೀಮವ್ವ” ಎಂಬ ಹೆಸರು ಬಂದಿರುತ್ತದೆ.

ಇಟಗಿಯ ಮಹದೇವ ದೇವಸ್ಥಾನದ ವೈಭವಶಾಲಿ ಶಿಲ್ಪಸೌಂದರ್ಯಕ್ಕೆ ಭಿನ್ನವಾಗಿ, ಭೀಮಾಂಬಿಕಾ ದೇವಸ್ಥಾನವು ಜನಪದ ಭಕ್ತಿ ಮತ್ತು ಜೀವಂತ ಧಾರ್ಮಿಕ ಪರಂಪರೆಯ ಪ್ರತೀಕವಾಗಿದೆ. ದಿನವೂ ಭಕ್ತರಿಂದ ಪೂಜೆ ನಡೆಯುತ್ತಿದ್ದು, ಆಚರಣೆಗಳ ಸಮಯದಲ್ಲಿ ಗದಗ್ ಹಾಗೂ ಸುತ್ತಮುತ್ತಲ ಜಿಲ್ಲೆಗಳಿಂದ ಸಾವಿರಾರು ಭಕ್ತರು ಸೇರುತ್ತಾರೆ.

ಗ್ರಾಮಾಂತರದ ಶಾಂತ ವಾತಾವರಣದ ಮಧ್ಯೆ ದೇವಾಲಯವು ಆತ್ಮಶಾಂತಿ, ಭಕ್ತಿಭಾವ ಮತ್ತು ಸಾಮಾಜಿಕ ಬಂಧುತ್ವವನ್ನು ಒಟ್ಟುಗೂಡಿಸುವ ಪವಿತ್ರ ತಾಣವಾಗಿದೆ.
""",

    images: _images(15),
    voiceFile: _voice(15),
  ),

];
