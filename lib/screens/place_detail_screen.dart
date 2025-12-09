import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/gadag_places_data.dart';
import '../services/favorites_controller.dart';
import '../services/audio_service.dart';
import '../services/language_provider.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🧭 PLACE DETAIL SCREEN
///
/// BEAUTIFUL + FEATURE RICH TOURIST DESTINATION VIEWER
///
/// SUPPORTS:
/// ✅ Animated gradient AppBar
/// ✅ Hero header image
/// ✅ Language toggle (EN ⇄ KN)
/// ✅ Google Maps navigation
/// ✅ Text-to-Speech narration (Audio)
/// ✅ Favorites support
/// ✅ Shimmer loading title
/// ✅ RichText themed description
/// ✅ Carousel slider
/// ✅ Image gallery grid
/// ✅ Hero fullscreen image zoom
///
///////////////////////////////////////////////////////////////////////////////

class PlaceDetailScreen extends StatelessWidget {
  final TouristPlace place;

  const PlaceDetailScreen({
    super.key,
    required this.place,
  });

  // =========================================================================
  // 🧱 MAIN UI ENTRY
  // =========================================================================
  @override
  Widget build(BuildContext context) {

    // 🌍 Read language state from Provider
    final lang = context.watch<LanguageProvider>();
    final isKannada = lang.isKannada;

    // ✅ Choose correct localized texts
    final title = isKannada ? place.nameKN : place.nameEN;
    final description = isKannada ? place.descKN : place.descEN;

    // ✅ Fallback image safety
    final heroImage = place.images.isNotEmpty
        ? place.images.first
        : "assets/images/placeholder.jpg";

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // 🌈 Animated gradient App Bar
      appBar: _buildAppBar(title),

      // 📜 Screen body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🎴 Hero image banner
            _HeroImage(image: heroImage, title: title),
            const SizedBox(height: 14),

            // 🚀 MAP | AUDIO | FAVORITE buttons
            _buildActionBar(context, description, isKannada),

            // 📍 Small location chip
            if (place.shortEN.isNotEmpty)
              _buildTag(place.shortEN),

            const SizedBox(height: 14),

            // 📖 RichText golden description card
            _buildDescriptionCard(description),

            const SizedBox(height: 18),

            // ✨ SHIMMER SECTION TITLE
            _buildShimmerHeader(),

            const SizedBox(height: 12),

            // 🎠 IMAGE SLIDER
            _buildCarousel(),

            const SizedBox(height: 20),

            // 🖼 GALLERY HEADER
            _buildGalleryTitle(),

            const SizedBox(height: 12),

            // 📷 GALLERY GRID
            _buildImageGrid(context),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // 🌟 GRADIENT APPBAR
  // =========================================================================
  PreferredSizeWidget _buildAppBar(String title) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),

      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFD700),
        ),
      ),

      flexibleSpace: AnimatedContainer(
        duration: const Duration(seconds: 4),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3F51B5),
              Color(0xFF512DA8),
              Color(0xFFFF9800),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 🚀 ACTION BAR — MAP | AUDIO | FAVORITE
  // =========================================================================
  Widget _buildActionBar(
      BuildContext context,
      String speakText,
      bool isKannada,
      ) {

    final favorites = context.watch<FavoritesController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        // 🗺 Google Maps
        _actionButton(
          icon: Icons.map,
          color: Colors.green,
          onTap: () => openMaps(place.nameEN),
        ),

        // 🔊 Text-to-Speech
        _actionButton(
          icon: Icons.volume_up,
          color: Colors.blue,
          onTap: () => AudioService().speak(speakText, isKannada),
        ),

        // ❤️ Favorites toggle
        CircleAvatar(
          backgroundColor: Colors.red.withOpacity(.15),

          child: IconButton(
            icon: Icon(
              favorites.isFavorite(place.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.redAccent,
            ),

            onPressed: () =>
                context.read<FavoritesController>()
                    .toggleFavorite(place.id),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // 🔘 ROUND ICON BUTTON
  // =========================================================================
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap
  }) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: color.withOpacity(.15),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: onTap,
      ),
    );
  }

  // =========================================================================
  // 📍 CHIP TAG
  // =========================================================================
  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Chip(
        avatar: const Icon(Icons.place, color: Colors.orange),
        backgroundColor: const Color(0xFFFFF3CD),
        label: Text(tag,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 📖 RICH TEXT DESCRIPTION
  // =========================================================================
  Widget _buildDescriptionCard(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF8E1),
              Color(0xFFFFE082),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(.20),
              blurRadius: 18,
            )
          ],
        ),

        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF3B2600),
              fontFamilyFallback: ["NotoKannada", "Roboto"],
            ),
            children: [
              const TextSpan(
                text: "✨ Gadag Heritage\n\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF9800),
                ),
              ),
              TextSpan(text: description),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // ✨ SHIMMER HEADER
  // =========================================================================
  Widget _buildShimmerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Shimmer.fromColors(
        baseColor: Colors.amber,
        highlightColor: Colors.white,
        child: const Text(
          "✨ Photo Highlights",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 🎠 IMAGE CAROUSEL
  // =========================================================================
  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),

      items: place.images.map((img) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          img,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      )).toList(),
    );
  }

  // =========================================================================
  // 🖼 GALLERY HEADER
  // =========================================================================
  Widget _buildGalleryTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.photo_library, color: Color(0xFFFF9800)),
          SizedBox(width: 8),
          Text(
            "Photo Gallery",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // 📷 IMAGE GRID
  // =========================================================================
  Widget _buildImageGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      padding: const EdgeInsets.symmetric(horizontal: 16),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),

      itemCount: place.images.length,

      itemBuilder: (_, i) {
        final img = place.images[i];

        return InkWell(
          borderRadius: BorderRadius.circular(18),

          onTap: () => _openFullImage(context, img),

          child: Hero(
            tag: img,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),

              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================================
  // 🔍 FULLSCREEN HERO IMAGE VIEWER
  // =========================================================================
  void _openFullImage(BuildContext context, String image) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,

          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),

          body: Center(
            child: Hero(
              tag: image,
              child: InteractiveViewer(
                maxScale: 5,
                child: Image.asset(image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🎴 HERO IMAGE HEADER WIDGET
///////////////////////////////////////////////////////////////////////////////
class _HeroImage extends StatelessWidget {

  final String image;
  final String title;

  const _HeroImage({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        ClipRRect(
          borderRadius:
          const BorderRadius.vertical(bottom: Radius.circular(28)),

          child: Image.asset(
            image,
            height: 240,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Dark overlay
        Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(28)),

            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.65),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Title overlay
        Positioned(
          bottom: 18,
          left: 20,
          right: 20,

          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// 🗺 GOOGLE MAPS OPENER
// =========================================================================
Future<void> openMaps(String placeName) async {

  final uri = Uri.parse(
    "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(placeName)}",
  );

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw "Could not launch Google Maps";
  }
}
