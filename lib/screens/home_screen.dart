import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///////////////////////////////////////////////////////////////////////////////
/// 📦 DATA & SERVICES
///////////////////////////////////////////////////////////////////////////////

import '../data/gadag_places_data.dart';         // 🔹 Tourist places dataset
import '../services/language_provider.dart';    // 🔹 Kannada ⇄ English provider
import '../widgets/app_drawer.dart';             // 🔹 Side navigation drawer
import 'place_detail_screen.dart';               // 🔹 Place detail page
import '../services/audio_service.dart';         // 🔹 Text-to-Speech service
import '../services/app_strings.dart';           // 🔹 Localization engine

///////////////////////////////////////////////////////////////////////////////
/// 🏠 HOME SCREEN — GADAG TOURIST PLACES LIST
///
/// FEATURES INCLUDED:
/// ---------------------------------------------------------------------------
/// ✅ Multi-language UI (English ⇄ Kannada)
/// ✅ Animated gradient AppBar with title RichText
/// ✅ Login dialog & profile bottom-sheet
/// ✅ Image thumbnails for every place
/// ✅ TTS audio preview for description
/// ✅ Drawer with language switch hooks
/// ✅ Clean UI layout + scrolling list
///////////////////////////////////////////////////////////////////////////////

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

///////////////////////////////////////////////////////////////////////////////
/// 🎯 STATE CONTROLLER
///////////////////////////////////////////////////////////////////////////////
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  ///////////////////////////////////////////////////////////////////////////////
  /// 🔐 LOGIN STATE
  ///////////////////////////////////////////////////////////////////////////////
  bool isLoggedIn = false;
  String userName = "";

  ///////////////////////////////////////////////////////////////////////////////
  /// 🌈 APPBAR GRADIENT ANIMATION
  ///////////////////////////////////////////////////////////////////////////////
  late final AnimationController _gradientCtrl;
  late final Animation<double> _gradientAnim;

  ///////////////////////////////////////////////////////////////////////////////
  /// ⚙ INIT STATE
  ///////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _gradientCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _gradientAnim = CurvedAnimation(
      parent: _gradientCtrl,
      curve: Curves.easeInOut,
    );
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// ♻ CLEANUP
  ///////////////////////////////////////////////////////////////////////////////
  @override
  void dispose() {
    _gradientCtrl.dispose();
    super.dispose();
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// 🔐 LOGIN DIALOG
  ///////////////////////////////////////////////////////////////////////////////
  Future<void> _showLoginDialog() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                radius: 28,
                child: Icon(Icons.lock, color: Colors.white),
              ),

              const SizedBox(height: 10),

              /// 🔹 LOCALIZED TITLE
              Text(
                AppStrings.of(context, "loginTitle"),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 10),

              /// 🔹 NAME INPUT
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: AppStrings.of(context, "loginHint"),
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppStrings.of(context, "cancel")),
                  ),

                  const SizedBox(width: 8),

                  ElevatedButton(
                    onPressed: () {

                      ///////////////////////////////////////////////////////////////////////////////
                      /// ✅ SAVE LOGIN STATE
                      ///////////////////////////////////////////////////////////////////////////////

                      setState(() {
                        userName = controller.text.isEmpty
                            ? AppStrings.of(context, "guest")
                            : controller.text;
                        isLoggedIn = true;
                      });

                      Navigator.pop(context);

                      _showSnack(
                        AppStrings.format(
                          context,
                          "welcome",
                          {"name": userName},
                        ),
                      );
                    },
                    child: Text(AppStrings.of(context, "loginBtn")),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// 👤 PROFILE BOTTOM SHEET
  ///////////////////////////////////////////////////////////////////////////////
  void _showProfile() {

    if (!isLoggedIn) {
      _showSnack(AppStrings.of(context, "needLogin"));
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(22),

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF512DA8), Color(0xFFFF9800)],
          ),
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(26)),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ///////////////////////////////////////////////////////////////////////////////
            /// 👤 AVATAR
            ///////////////////////////////////////////////////////////////////////////////
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 48),
            ),

            const SizedBox(height: 12),

            ///////////////////////////////////////////////////////////////////////////////
            /// 💬 GREETING RICHTEXT
            ///////////////////////////////////////////////////////////////////////////////
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(text: "👋 "),
                  TextSpan(
                    text: userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ///////////////////////////////////////////////////////////////////////////////
            /// 🚪 LOGOUT BUTTON
            ///////////////////////////////////////////////////////////////////////////////
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(AppStrings.of(context, "logout")),
              onPressed: () {
                setState(() {
                  isLoggedIn = false;
                  userName = "";
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// 🔔 COMMON SNACK BAR
  ///////////////////////////////////////////////////////////////////////////////
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// 🔊 AUDIO PREVIEW — TEXT TO SPEECH
  ///////////////////////////////////////////////////////////////////////////////
  Future<void> _audioPreview(String text, bool isKannada) async {
    try {
      final tts = AudioService();
      await tts.speak(text, isKannada);
    } catch (e) {
      _showSnack("❌ Audio playback failed");
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  /// ✅ MAIN BUILD
  ///////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final bool isKannada = lang.isKannada;
    final places = gadagPlaces;

    return Scaffold(
      drawer: AppDrawer(
        showLogin: _showLoginDialog,
        showProfile: _showProfile,
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AnimatedBuilder(
          animation: _gradientAnim,
          builder: (_, __) {
            return AppBar(
              elevation: 6,
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                        const Color(0xFF3F51B5),
                        const Color(0xFFFF9800),
                        _gradientAnim.value,
                      )!,
                      Color.lerp(
                        const Color(0xFF7B1FA2),
                        const Color(0xFFFFC107),
                        1 - _gradientAnim.value,
                      )!,
                    ],
                  ),
                ),
              ),
              title: Column(
                children: [
                  const Text(
                    "Gadag Travel Guide",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    AppStrings.of(context, "appTitle"),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (_, index) {
          final place = places[index];
          final title = isKannada ? place.nameKN : place.nameEN;
          final subtitle = isKannada ? place.shortKN : place.shortEN;
          final description = isKannada ? place.descKN : place.descEN;
          final thumb = place.images.isNotEmpty ? place.images.first : null;

          return ListTile(
            leading: thumb != null
                ? Image.asset(
              thumb,
              width: 60,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.image_not_supported),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () => _audioPreview(
                description,
                isKannada,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PlaceDetailScreen(place: place),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
