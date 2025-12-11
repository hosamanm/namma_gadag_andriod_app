import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

////////////////////////////////////////////////////////////////////////////////
/// 🌐 PROVIDERS
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
////////////////////////////////////////////////////////////////////////////////

class AppDrawer extends StatefulWidget {
  final VoidCallback showLogin;
  final VoidCallback showProfile;

  const AppDrawer({
    super.key,
    required this.showLogin,
    required this.showProfile,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {

  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();

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

  /// Helper method to launch a URL. Shows a debug error if it fails.
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
      // Optionally, show a SnackBar to the user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open the link.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final theme = context.watch<ThemeController>();

    final tAppTitle = lang.isKannada ? "ನಮ್ಮ ಗದಗ" : "Namma Gadag";
    final tLogin = lang.isKannada ? "ಲಾಗಿನ್" : "Login";
    final tProfile = lang.isKannada ? "ಪ್ರೊಫೈಲ್" : "Profile";
    final tVideo = lang.isKannada ? "ವೀಡಿಯೊ ಗ್ಯಾಲರಿ" : "Video Gallery";
    final tImage = lang.isKannada ? "ಚಿತ್ರ ಗ್ಯಾಲರಿ" : "Image Gallery";
    final tTheme = theme.isDark ? "Dark Mode" : "Light Mode";
    final tLangLabel = lang.currentLanguageLabel;
    final tPrivacy = lang.isKannada ? "ಗೌಪ್ಯತಾ ನೀತಿ" : "Privacy Policy";
    final tRate = lang.isKannada ? "ರೇಟ್ ಮಾಡಿ" : "Rating";

    // IMPORTANT: Replace with your actual package name
    const String appPackageName = "com.example.namma_gadag";

    return Drawer(
      width: MediaQuery.of(context).size.width * .86,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.black.withOpacity(0.06)),
          ),
          Column(
            children: [
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
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 2,
                                color: const Color(0xFFE4B23D).withOpacity(
                                  .3 + _glowController.value * .4,
                                ),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("assets/avatar.jpg"),
                          ),
                        ),
                        const SizedBox(width: 12),
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
              Padding(
                padding: const EdgeInsets.all(14),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 2.9,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: [
                    _glowButton(
                      icon: Icons.login,
                      title: tLogin,
                      tap: widget.showLogin,
                    ),
                    _glowButton(
                      icon: Icons.person,
                      title: tProfile,
                      tap: widget.showProfile,
                    ),
                    _glowButton(
                      icon: Icons.language,
                      title: tLangLabel,
                      tap: lang.toggleLanguage,
                    ),
                    _glowButton(
                      icon: theme.isDark ? Icons.dark_mode : Icons.light_mode,
                      title: tTheme,
                      tap: theme.toggleTheme,
                    ),
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
                    _glowButton(
                      icon: Icons.privacy_tip,
                      title: tPrivacy,
                      tap: () => _launchUrl("https://sites.google.com/view/nammagadagprivacypolicy"),
                    ),
                    _glowButton(
                      icon: Icons.star_rate,
                      title: tRate,
                      tap: () => _launchUrl("https://play.google.com/store/apps/details?id=$appPackageName"),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0D47A1).withOpacity(.8),
                      const Color(0xFFE4B23D).withOpacity(.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black26)],
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Created by\n",
                        style: TextStyle(fontSize: 11, color: Colors.white70),
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
