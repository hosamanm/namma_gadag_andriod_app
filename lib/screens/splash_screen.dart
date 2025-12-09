import 'dart:async';

////////////////////////////////////////////////////////////
/// FLUTTER CORE
////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';

////////////////////////////////////////////////////////////
/// AUDIO PLAYER
////////////////////////////////////////////////////////////

import 'package:audioplayers/audioplayers.dart';

////////////////////////////////////////////////////////////
/// HOME SCREEN NAVIGATION TARGET
////////////////////////////////////////////////////////////

import 'home_screen.dart';

////////////////////////////////////////////////////////////
/// 🌟 SPLASH SCREEN
/// Animated intro with music + fade/scale motion effects
////////////////////////////////////////////////////////////

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

////////////////////////////////////////////////////////////
/// 🎬 SPLASH STATE (Animation Controller)
////////////////////////////////////////////////////////////

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

////////////////////////////////////////////////////////////
  /// 🎥 ANIMATION CONTROLLER
////////////////////////////////////////////////////////////

  late final AnimationController _controller;

  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

////////////////////////////////////////////////////////////
  /// 🔊 AUDIO PLAYER
////////////////////////////////////////////////////////////

  final AudioPlayer _player = AudioPlayer();

////////////////////////////////////////////////////////////
  /// 🚀 INIT
////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();

////////////////////////////////////////////////////////////
    /// ✅ SETUP ANIMATION
////////////////////////////////////////////////////////////

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

////////////////////////////////////////////////////////////
    /// ✨ FADE EFFECT
////////////////////////////////////////////////////////////

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

////////////////////////////////////////////////////////////
    /// 🔍 SCALE EFFECT
////////////////////////////////////////////////////////////

    _scaleAnim = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

////////////////////////////////////////////////////////////
    /// ▶ START ANIMATION
////////////////////////////////////////////////////////////

    _controller.forward();

////////////////////////////////////////////////////////////
    /// ▶ PLAY SPLASH AUDIO
////////////////////////////////////////////////////////////

    _player.play(
      AssetSource("audio/splash_music.mp3"),
      volume: 1.0,
    );

////////////////////////////////////////////////////////////
    /// ⏭ AUTO NAVIGATE TO HOME
////////////////////////////////////////////////////////////

    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });
  }

////////////////////////////////////////////////////////////
  /// 🧹 CLEANUP
////////////////////////////////////////////////////////////

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    _controller.dispose();
    super.dispose();
  }

////////////////////////////////////////////////////////////
  /// 🖌 UI BUILD
////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(

////////////////////////////////////////////////////////////
      /// 🖥 FULLSCREEN STACK
////////////////////////////////////////////////////////////

      body: Stack(
        fit: StackFit.expand,
        children: [

////////////////////////////////////////////////////////////
          /// 🔷 BACKGROUND IMAGE
////////////////////////////////////////////////////////////

          Image.asset(
            "assets/splash.jpg",
            fit: BoxFit.cover,
          ),

////////////////////////////////////////////////////////////
          /// 🌑 GLASS DARK GRADIENT OVERLAY
////////////////////////////////////////////////////////////

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.70),
                  Colors.black.withOpacity(0.40),
                  Colors.black.withOpacity(0.70),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

////////////////////////////////////////////////////////////
          /// ✨ CENTER TEXT - ANIMATED FADE + SCALE
////////////////////////////////////////////////////////////

          FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Center(

////////////////////////////////////////////////////////////
                /// 📦 MAIN CONTENT COLUMN
////////////////////////////////////////////////////////////

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

////////////////////////////////////////////////////////////
                    /// ⭐ MAIN BRAND TITLE
////////////////////////////////////////////////////////////

                    Text(
                      "Discover Gadag",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFFD700),

                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            blurRadius: 12,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                    ),

////////////////////////////////////////////////////////////
                    /// 🌿 ENGLISH SUBTITLE
////////////////////////////////////////////////////////////

                    SizedBox(height: 8),

                    Text(
                      "Tourist Places",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,

                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),

////////////////////////////////////////////////////////////
                    /// 🏵 KANNADA TAGLINE
////////////////////////////////////////////////////////////

                    SizedBox(height: 12),

                    Text(
                      "ಗದಗದ ಸುಂದರ ಪ್ರವಾಸಿ ತಾಣಗಳು",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),

////////////////////////////////////////////////////////////
                    /// ⏳ LOADING INDICATOR
////////////////////////////////////////////////////////////

                    SizedBox(height: 40),

                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor:
                        AlwaysStoppedAnimation(Color(0xFFFFD700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

