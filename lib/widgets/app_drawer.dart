import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

////////////////////////////////////////////////////////////////////////////////
/// 🌐 PROVIDERS
///
/// - LanguageProvider  → Kannada / English toggle
/// - ThemeController   → Light / Dark theme switch
////////////////////////////////////////////////////////////////////////////////

import '../services/language_provider.dart';
import '../services/theme_controller.dart';

////////////////////////////////////////////////////////////////////////////////
/// 🖼 FEATURE SCREENS
////////////////////////////////////////////////////////////////////////////////

import '../screens/video_gallery_screen.dart';
import '../screens/image_gallery_screen.dart';

////////////////////////////////////////////////////////////////////////////////
/// 🌟 PREMIUM GLASS EFFECT DRAWER
///
/// FEATURES INCLUDED:
///
/// ✅ Kannada ⇄ English language switching
/// ✅ Theme toggle (Light / Dark)
/// ✅ Audio narration hooks ready
/// ✅ Video Gallery navigation
/// ✅ Image Gallery navigation
/// ✅ Glass blur background
/// ✅ Animated glowing avatar
/// ✅ RichText creator credit badge
/// ✅ Responsive grid menu
/// ✅ Clean architecture
////////////////////////////////////////////////////////////////////////////////

class AppDrawer extends StatefulWidget {
  final VoidCallback showLogin;
  final VoidCallback showProfile;

  /// ✅ CONST constructor eliminates Flutter warnings
  const AppDrawer({
    super.key,
    required this.showLogin,
    required this.showProfile,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

////////////////////////////////////////////////////////////////////////////////
/// 🔥 GLOW ANIMATION STATE
////////////////////////////////////////////////////////////////////////////////
class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {

  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    /// Repeating glow loop animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

////////////////////////////////////////////////////////////////////////////////
  /// 🧱 MAIN BUILD
////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    ////////////////////////////////////////////////////////////////////////////
    /// PROVIDER ACCESS
    ////////////////////////////////////////////////////////////////////////////
    final lang   = context.watch<LanguageProvider>();
    final theme = context.watch<ThemeController>();

    ////////////////////////////////////////////////////////////////////////////
    /// LANGUAGE-BASED TEXT LABELS
    ////////////////////////////////////////////////////////////////////////////
    final tAppTitle  = lang.isKannada ? "ನಮ್ಮ ಗದಗ" : "Namma Gadag";
    final tLogin     = lang.isKannada ? "ಲಾಗಿನ್" : "Login";
    final tProfile   = lang.isKannada ? "ಪ್ರೊಫೈಲ್" : "Profile";
    final tVideo     = lang.isKannada ? "ವೀಡಿಯೊ ಗ್ಯಾಲರಿ" : "Video Gallery";
    final tImage     = lang.isKannada ? "ಚಿತ್ರ ಗ್ಯಾಲರಿ" : "Image Gallery";
    final tTheme     = theme.isDark ? "Dark Mode" : "Light Mode";

    final tLangLabel = lang.currentLanguageLabel;

    ////////////////////////////////////////////////////////////////////////////
    /// ROOT DRAWER
    ////////////////////////////////////////////////////////////////////////////
    return Drawer(
      width: MediaQuery.of(context).size.width * .86,

      child: Stack(
        children: [

//////////////////////////////////////////////////////////////////////////////
// 🌫 BACKDROP BLUR (GLASS EFFECT)
//////////////////////////////////////////////////////////////////////////////
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.black.withOpacity(0.06)),
          ),

//////////////////////////////////////////////////////////////////////////////
// 📋 CONTENT LAYOUT
//////////////////////////////////////////////////////////////////////////////
          Column(
            children: [

//////////////////////////////////////////////////////////////////////////////
// 🎨 HEADER WITH GLOW AVATAR
//////////////////////////////////////////////////////////////////////////////
              AnimatedBuilder(
                animation: _glowController,
                builder: (_, __) {
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0D47A1),
                          const Color(0xFFE4B23D).withOpacity(
                            .3 + _glowController.value * .4,
                          ),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [

//////////////////////////////////////////////////////////////////////////////
// 🔮 ANIMATED GOLD AVATAR
//////////////////////////////////////////////////////////////////////////////
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 2,
                                color: const Color(0xFFE4B23D)
                                    .withOpacity(
                                  .3 + _glowController.value * .4,
                                ),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            AssetImage("assets/avatar.jpg"),
                          ),
                        ),

                        const SizedBox(width: 12),

//////////////////////////////////////////////////////////////////////////////
// 🏛 TITLE TEXT
//////////////////////////////////////////////////////////////////////////////
                        Text(
                          tAppTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

//////////////////////////////////////////////////////////////////////////////
// 🔘 FEATURE GRID
//////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.all(14),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 2.9,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: [

                    /// LOGIN
                    _glowButton(
                      icon: Icons.login,
                      title: tLogin,
                      tap: widget.showLogin,
                    ),

                    /// PROFILE
                    _glowButton(
                      icon: Icons.person,
                      title: tProfile,
                      tap: widget.showProfile,
                    ),

                    /// LANGUAGE TOGGLE
                    _glowButton(
                      icon: Icons.language,
                      title: tLangLabel,
                      tap: lang.toggleLanguage,
                    ),

                    /// THEME TOGGLE
                    _glowButton(
                      icon:
                      theme.isDark ? Icons.dark_mode : Icons.light_mode,
                      title: tTheme,
                      tap: theme.toggleTheme,
                    ),

                    /// VIDEO GALLERY
                    _glowButton(
                      icon: Icons.video_collection_rounded,
                      title: tVideo,
                      tap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VideoGalleryScreen(),
                        ),
                      ),
                    ),

                    /// IMAGE GALLERY
                    _glowButton(
                      icon: Icons.image_rounded,
                      title: tImage,
                      tap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ImageGalleryScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

//////////////////////////////////////////////////////////////////////////////
// 🏆 RICH CREDIT BADGE
//////////////////////////////////////////////////////////////////////////////
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0D47A1).withOpacity(.8),
                      const Color(0xFFE4B23D).withOpacity(.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Colors.black26)
                  ],
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Created by\n",
                        style:
                        TextStyle(fontSize: 11, color: Colors.white70),
                      ),
                      TextSpan(
                        text: "MANJUNATH KALAKAPPA HOSAMANI",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .6,
                          color: Color(0xFFFFEB3B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

//////////////////////////////////////////////////////////////////////////////
// 📸 USER PHOTO
//////////////////////////////////////////////////////////////////////////////
              const Padding(
                padding: EdgeInsets.all(14),
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
              ),

              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
  /// ✨ PREMIUM GLOW BUTTON
////////////////////////////////////////////////////////////////////////////////
  Widget _glowButton({
    required IconData icon,
    required String title,
    required VoidCallback tap,
  }) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(14),
      splashColor: const Color(0xFFE4B23D).withOpacity(.25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0D47A1),
              Color(0xFFE4B23D),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(blurRadius: 6, color: Colors.black26),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
