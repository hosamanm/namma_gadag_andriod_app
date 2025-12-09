import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

////////////////////////////////////////////////////////////
/// 🌐 PROVIDERS
////////////////////////////////////////////////////////////
import '../services/language_provider.dart';
import '../services/app_strings.dart';

////////////////////////////////////////////////////////////
/// 📦 DATA
////////////////////////////////////////////////////////////
import '../data/gadag_places_data.dart';

////////////////////////////////////////////////////////////
/// 📄 NAVIGATION
////////////////////////////////////////////////////////////
import 'place_detail_screen.dart';

////////////////////////////////////////////////////////////
/// 🌄 PLACE LIST SCREEN
/// • Rich visual UI
/// • Gradient AppBar
/// • Localized text (English ⇄ Kannada)
/// • Image thumbnails
/// • Smooth navigation
////////////////////////////////////////////////////////////

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ////////////////////////////////////////////////////////////
    /// 🌐 READ CURRENT LANGUAGE
    ////////////////////////////////////////////////////////////
    final isKannada =
        context.watch<LanguageProvider>().isKannada;

    return Scaffold(

////////////////////////////////////////////////////////////
      /// ⭐ APP BAR – GOLDEN PREMIUM HEADER
////////////////////////////////////////////////////////////

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,

        // 🌍 APP TITLE (Localized)
        title: Text(
          AppStrings.of(context, "appTitle"),
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            fontSize: 17,
          ),
        ),

        // 🌟 RICH GRADIENT BACKGROUND
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        ////////////////////////////////////////////////////////
        /// 🌐 LANGUAGE TOGGLE BUTTON
        ////////////////////////////////////////////////////////

        actions: [

          IconButton(
            tooltip: context
                .watch<LanguageProvider>()
                .currentLanguageLabel,

            icon: const Icon(Icons.language),
            onPressed: () {
              context
                  .read<LanguageProvider>()
                  .toggleLanguage();
            },
          ),

        ],
      ),

////////////////////////////////////////////////////////////
      /// 📜 PLACE LIST BODY
////////////////////////////////////////////////////////////

      body: ListView.builder(

        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10),

////////////////////////////////////////////////////////////
        /// 🔢 TOTAL ITEMS
////////////////////////////////////////////////////////////

        itemCount: gadagPlaces.length,

////////////////////////////////////////////////////////////
        /// 🃏 CARD BUILDER
////////////////////////////////////////////////////////////

        itemBuilder: (context, index) {

          final place = gadagPlaces[index];

          //////////////////////////////////////////////////////
          /// 🌍 PICK LANGUAGE-SPECIFIC TEXT
          //////////////////////////////////////////////////////

          final title =
          isKannada ? place.nameKN : place.nameEN;

          final subtitle =
          isKannada ? place.shortKN : place.shortEN;

////////////////////////////////////////////////////////////
          /// 🧾 CARD UI
////////////////////////////////////////////////////////////

          return Card(
            elevation: 6,
            shadowColor: Colors.black26,

            margin: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

////////////////////////////////////////////////////////////
            /// ✨ RIPPLE TOUCH EFFECT
////////////////////////////////////////////////////////////

            child: InkWell(
              borderRadius: BorderRadius.circular(16),

////////////////////////////////////////////////////////////
              /// 👉 NAVIGATE TO DETAIL PAGE
////////////////////////////////////////////////////////////

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PlaceDetailScreen(place: place),
                  ),
                );
              },

////////////////////////////////////////////////////////////
              /// 📐 CARD LAYOUT
////////////////////////////////////////////////////////////

              child: Padding(
                padding: const EdgeInsets.all(10),

                child: Row(
                  children: [

////////////////////////////////////////////////////////////
                    /// 🖼 IMAGE THUMBNAIL
////////////////////////////////////////////////////////////

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(14),

                      child: Image.asset(
                        place.images.first,

                        height: 70,
                        width: 70,

                        fit: BoxFit.cover,

                        // ✅ Shows fallback icon if image fails
                        errorBuilder:
                            (_, __, ___) =>
                            Container(
                              height: 70,
                              width: 70,
                              color: Colors.grey.shade300,
                              child:
                              const Icon(Icons.image),
                            ),
                      ),
                    ),

                    const SizedBox(width: 14),

////////////////////////////////////////////////////////////
                    /// 📝 RICH TEXT SECTION
////////////////////////////////////////////////////////////

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

////////////////////////////////////////////////////////
                          /// 📌 PLACE TITLE (RICH STYLE)
////////////////////////////////////////////////////////

                          Text(
                            title,
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.w700,
                              height: 1.2,
                              letterSpacing: .2,
                            ),
                          ),

                          const SizedBox(height: 4),

////////////////////////////////////////////////////////
                          /// 🏷 PLACE SHORT DESCRIPTION
////////////////////////////////////////////////////////

                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,

                            style: TextStyle(
                              fontSize: 13.5,
                              height: 1.4,
                              color:
                              Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),

////////////////////////////////////////////////////////////
                    /// ➡️ RIGHT CHEVRON ICON
////////////////////////////////////////////////////////////

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
