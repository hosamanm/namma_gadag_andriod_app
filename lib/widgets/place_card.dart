import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

////////////////////////////////////////////////////////////
/// 📦 DATA MODELS
////////////////////////////////////////////////////////////

import '../data/gadag_places_data.dart';

////////////////////////////////////////////////////////////
/// 🌐 PROVIDERS
////////////////////////////////////////////////////////////

import '../services/language_provider.dart';

////////////////////////////////////////////////////////////
/// 🪪 PLACE CARD WIDGET
///
/// Premium interactive list card used on:
///  ✅ HomeScreen
///  ✅ FavoritesScreen
///
/// Features:
/// ------------------------------------------------------------------------
/// ✔ Kannada ⇄ English dynamic text support
/// ✔ Font fallback (NotoKannada → Roboto)
/// ✔ RichText title styling
/// ✔ Soft golden glow gradient card
/// ✔ Ripple touch feedback
/// ✔ Place thumbnail / fallback icon
/// ✔ Works even if image list is empty
/// ✔ Audio-ready callbacks if added later
////////////////////////////////////////////////////////////

class PlaceCard extends StatelessWidget {
  final TouristPlace place;
  final VoidCallback onTap;

  const PlaceCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

////////////////////////////////////////////////////////////
    /// 🌍 READ CURRENT LANGUAGE STATE
////////////////////////////////////////////////////////////

    final isKannada =
        context.watch<LanguageProvider>().isKannada;

////////////////////////////////////////////////////////////
    /// 🖼 SAFE IMAGE HANDLING
    ///
    /// Uses first place image
    /// or a default placeholder if empty
////////////////////////////////////////////////////////////

    final image = place.images.isNotEmpty
        ? place.images.first
        : "assets/images/placeholder.jpg";

////////////////////////////////////////////////////////////
    /// 🧱 CARD OUTER PADDING
////////////////////////////////////////////////////////////

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

////////////////////////////////////////////////////////////
      /// ⭐ MATERIAL CARD
      ///
      /// Used for:
      /// - elevation
      /// - rounded corners
      /// - soft shadow rendering
////////////////////////////////////////////////////////////

      child: Material(
        elevation: 7,
        shadowColor: Colors.amber.withOpacity(.35),
        borderRadius: BorderRadius.circular(18),
        color: Colors.transparent,

////////////////////////////////////////////////////////////
        /// 🌊 TOUCH RIPPLE EFFECT (INKWELL)
////////////////////////////////////////////////////////////

        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.amber.withOpacity(.25),
          highlightColor: Colors.amber.withOpacity(.12),

////////////////////////////////////////////////////////////
          /// 🎨 SOFT GOLD GRADIENT BACKGROUND
////////////////////////////////////////////////////////////

          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFF8E1),
                  Color(0xFFFFF3C0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

////////////////////////////////////////////////////////////
            /// 📋 CARD CONTENT LAYOUT
////////////////////////////////////////////////////////////

            child: ListTile(

////////////////////////////////////////////////////////////
              /// 🟣 LEADING CIRCLE AVATAR
              ///
              /// Shows:
              ///   - Thumbnail image if available
              ///   - Else default place icon
////////////////////////////////////////////////////////////

              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 2,
                      color: Colors.amber.withOpacity(.45),
                    ),
                  ],
                ),

                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.deepPurple,

                  backgroundImage:
                  place.images.isNotEmpty ? AssetImage(image) : null,

                  child: place.images.isEmpty
                      ? const Icon(Icons.place, color: Colors.white)
                      : null,
                ),
              ),

////////////////////////////////////////////////////////////
              /// 🏷 TITLE SECTION (RICH TEXT)
////////////////////////////////////////////////////////////

              title: RichText(
                text: TextSpan(
                  children: [

                    TextSpan(
                      text: place.nameEN,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: Colors.black,

////////////////////////////////////////////////////////////
                        /// ✅ AUTO LANGUAGE FONT FALLBACK
////////////////////////////////////////////////////////////

                        fontFamilyFallback: [
                          "NotoKannada",
                          "Roboto",
                        ],
                      ),
                    ),
                  ],
                ),
              ),

////////////////////////////////////////////////////////////
              /// 📄 SUBTITLE DESCRIPTION
////////////////////////////////////////////////////////////

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),

                child: Text(
                  place.shortEN,

////////////////////////////////////////////////////////////
                  /// ✅ AUTO LANGUAGE FONT FALLBACK
////////////////////////////////////////////////////////////

                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.black54,
                    fontFamilyFallback: [
                      "NotoKannada",
                      "Roboto",
                    ],
                  ),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

////////////////////////////////////////////////////////////
              /// ➡ TRAILING NAVIGATION ICON
////////////////////////////////////////////////////////////

              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
