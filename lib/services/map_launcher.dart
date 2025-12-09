import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

////////////////////////////////////////////////////////////////////////////////
/// 🗺 MAP LAUNCHER SERVICE — Namma Gadag
///
/// This single service enables your entire app to launch Google Maps with:
///
/// ✅ Language switching (Kannada ⇄ English)
/// ✅ Unicode-safe queries (Kannada text supported properly)
/// ✅ External native Google Maps launching
/// ✅ Rich UI feedback (snackbars)
/// ✅ Integration with:
///       • Image tile taps
///       • Rich-text buttons / clickable spans
///       • Audio narration call-to-action widgets
///
/// ---------------------------------------------------------------------------
///
/// EXAMPLES
///
/// ▶ From image tile tap:
///    MapLauncher.open("Trikuteshwara Temple Gadag");
///
/// ▶ Language-aware launching:
///    MapLauncher.open(
///       lang.isKannada ? place.nameKN : place.nameEN,
///       context: context,
///    );
///
/// ▶ From audio playback CTA:
///    ElevatedButton(
///       onPressed: () => MapLauncher.open(place.nameEN),
///       child: Text("🎧 Hear & Navigate")
///    );
///
/// ▶ With coordinates:
///    MapLauncher.open("15.4311, 75.6350");
///
////////////////////////////////////////////////////////////////////////////////

class MapLauncher {

  //##########################################################################
  // 🚀 MAIN PUBLIC METHOD
  //##########################################################################

  /// Opens Google Maps as an external app.
  ///
  /// ------------------------------------------------------------------------
  /// PARAMETERS:
  ///
  /// ► [placeQuery]  : Any valid search query
  ///                   • Place Name
  ///                   • Address
  ///                   • Kannada Text
  ///                   • GPS Coordinates
  ///
  /// ► [context]     : Optional but recommended
  ///                   Allows graceful UI error feedback via SnackBar
  ///
  /// ------------------------------------------------------------------------
  static Future<void> open(
      String placeQuery, {
        BuildContext? context,
      }) async {

    //----------------------------------------------------------------------
    // 🌍 Encode Unicode text (CRITICAL for Kannada language support)
    //
    // Prevents breaking URLs with:
    //    ಕನ್ನಡ ದೇವಸ್ಥಾನ
    //    Shrinivasa Temple
    //----------------------------------------------------------------------
    final String encodedQuery = Uri.encodeComponent(placeQuery);

    //----------------------------------------------------------------------
    // 🔗 Construct Google Maps Search URI
    //----------------------------------------------------------------------
    final Uri mapUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$encodedQuery",
    );

    //----------------------------------------------------------------------
    // 📲 Launch using system Maps application
    //----------------------------------------------------------------------
    final bool success = await launchUrl(
      mapUri,
      mode: LaunchMode.externalApplication,
    );

    //----------------------------------------------------------------------
    // ⚠️ Graceful error feedback
    //----------------------------------------------------------------------
    if (!success) {

      // ✅ Show friendly UI message if context exists
      if (context != null) {
        _showErrorSnackBar(
          context,
          "❌ Unable to open Google Maps",
        );
      }

      // ❗ Crash silently only during debugging
      else {
        throw Exception("Could not open Google Maps for: $placeQuery");
      }
    }
  }

  //##########################################################################
  // 🎨 ERROR SNACKBAR UI
  //##########################################################################

  /// Beautiful floating snackbar to notify failures
  ///
  /// This keeps UX clean without interrupting the user flow.
  ///
  static void _showErrorSnackBar(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,

        content: Row(
          children: [

            const Icon(
              Icons.location_off_rounded,
              color: Colors.white,
              size: 24,
            ),

            const SizedBox(width: 12),

            //----------------------------------------------------------
            // ✨ Rich text styling
            //----------------------------------------------------------
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
