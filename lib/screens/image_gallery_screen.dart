import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////////////
// 🖼 IMAGE GALLERY SCREEN
// ---------------------------------------------------------------
// Features:
//  ✔ Gradient AppBar
//  ✔ Responsive GridView (3 columns)
//  ✔ Hero animation on tap
//  ✔ Fullscreen image preview
//  ✔ Smooth transitions
//////////////////////////////////////////////////////////////////////

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({super.key});

  // ----------------------------------------------------------------
  // 🗂 DEMO IMAGES
  // NOTE:
  // Add your real images into `assets/gallery/` folder
  // & update pubspec.yaml.
  // ----------------------------------------------------------------
  static final List<String> galleryImages = List.generate(
    25,
        (i) => "assets/gallery/img_${(i % 25) + 1}.jpg",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      //--------------------------------------------------------------
      // 🧭 GRADIENT APPBAR
      //--------------------------------------------------------------
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: const Text("📸 Image Gallery"),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1), // Deep Blue
                Color(0xFFE4B23D), // Gold
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      //--------------------------------------------------------------
      // 🧱 IMAGE GRID
      //--------------------------------------------------------------
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: galleryImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),

          itemBuilder: (context, index) {
            final image = galleryImages[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => _ImagePreview(
                      imagePath: image,
                      heroTag: "img_$index",
                    ),
                  ),
                );
              },

              //------------------------------------------------------
              // HERO + IMAGE TILE
              //------------------------------------------------------
              child: Hero(
                tag: "img_$index",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
// 🔍 FULLSCREEN IMAGE PREVIEW
//////////////////////////////////////////////////////////////////////
class _ImagePreview extends StatelessWidget {
  final String imagePath;
  final String heroTag;

  const _ImagePreview({
    required this.imagePath,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      //--------------------------------------------------------------
      // TAP TO EXIT
      //--------------------------------------------------------------
      body: GestureDetector(
        onTap: () => Navigator.pop(context),

        child: Center(
          child: Hero(
            tag: heroTag,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1,
              maxScale: 4,

              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
