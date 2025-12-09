import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/demo_videos.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🎬 VIDEO GALLERY SCREEN
///////////////////////////////////////////////////////////////////////////////
///
/// Displays Gadag tourism demo videos in a scrollable list and opens
/// selected videos in the device browser or default player using URL launcher.
///
/// FEATURES:
/// ✅ Simple card-based UI
/// ✅ Safe external video opening
/// ✅ Clean error handling
/// ✅ Compatible with refined `DemoVideo` model
///
///////////////////////////////////////////////////////////////////////////////

class VideoGalleryScreen extends StatelessWidget {
  const VideoGalleryScreen({super.key});

  // --------------------------------------------------------------------------
  // ▶️ OPEN VIDEO LINK
  // --------------------------------------------------------------------------
  /// Launches the provided video URL using device external applications
  /// (browser / YouTube / video player, etc).
  ///
  /// [url] → Must be valid http/https video link
  // --------------------------------------------------------------------------
  Future<void> _openVideo(String url) async {
    final Uri uri = Uri.parse(url);

    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw "❌ Unable to open video link: $url";
    }
  }

  // --------------------------------------------------------------------------
  // 🖼️ BUILD UI
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // -----------------------------
      // 🌟 APP BAR
      // -----------------------------
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "🎬 Video Gallery",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
      ),

      // -----------------------------
      // 📜 VIDEO LIST
      // -----------------------------
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: demoVideos.length,
        itemBuilder: (context, index) {
          final video = demoVideos[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            // -----------------------------
            // ▶️ VIDEO TILE
            // -----------------------------
            child: ListTile(
              leading: const Icon(
                Icons.play_circle_fill,
                size: 36,
                color: Colors.redAccent,
              ),

              // ✅ FIXED: use `title`, not `titleKN`
              title: Text(
                video.titleKN,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              subtitle: const Text("Tap to play video"),

              trailing: const Icon(Icons.open_in_new),

              // ✅ FIXED: works now because `url` exists in DemoVideo model
              onTap: () => _openVideo(video.videoUrl),
            ),
          );
        },
      ),
    );
  }
}
