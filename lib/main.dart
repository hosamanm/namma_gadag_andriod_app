import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/theme_controller.dart';
import 'services/language_provider.dart';
import 'services/favorites_controller.dart';
import 'screens/splash_screen.dart';

///////////////////////////////////////////////////////////////////////////////
/// 🚀 APPLICATION ENTRY POINT
///////////////////////////////////////////////////////////////////////////////
///
/// ✅ This file boots the entire app
/// ✅ Registers app-wide providers:
///
///    🌗 ThemeController     → Light / Dark Mode
///    🌍 LanguageProvider    → English ⇄ Kannada switching
///    ⭐ FavoritesController→ Favourite tourist places list
///
/// ✅ Providers use ChangeNotifier
/// ✅ MultiProvider allows global access anywhere in the UI
///
///////////////////////////////////////////////////////////////////////////////

void main() {

  runApp(

    ///////////////////////////////////////////////////////////////////////////
    /// 🔗 MULTI PROVIDER ROOT
    ///////////////////////////////////////////////////////////////////////////

    MultiProvider(

      providers: [

        //////////////////////////////////////////////////////////////////////
        /// 🌟 THEME PROVIDER
        ///
        /// Handles:
        ///   - Light ⇄ Dark theme switching
        //////////////////////////////////////////////////////////////////////
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),

        //////////////////////////////////////////////////////////////////////
        /// 🌍 LANGUAGE PROVIDER
        ///
        /// Handles:
        ///   - English ⇄ Kannada toggle
        ///   - Text switching in UI widgets
        //////////////////////////////////////////////////////////////////////
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),

        //////////////////////////////////////////////////////////////////////
        /// ⭐ FAVORITES PROVIDER
        ///
        /// Handles:
        ///   - Save/remove favorite tourist places
        ///   - Real-time UI update if place is liked/unliked
        //////////////////////////////////////////////////////////////////////
        ChangeNotifierProvider(
          create: (_) => FavoritesController(),
        ),
      ],

      ////////////////////////////////////////////////////////////////////////
      /// 🚀 LAUNCH ROOT WIDGET
      ////////////////////////////////////////////////////////////////////////
      child: const MyApp(),
    ),
  );
}

///////////////////////////////////////////////////////////////////////////////
/// 🌍 ROOT APPLICATION WIDGET
///////////////////////////////////////////////////////////////////////////////
///
/// ✅ Wraps the whole project with MaterialApp
/// ✅ Listens to ThemeController to switch themes instantly
/// ✅ Routes to Splash Screen first
///
///////////////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------------------
    // 🌗 WATCH THEME PROVIDER
    // ----------------------------------------------------------------------
    //
    // watch() ensures UI rebuilds immediately when theme toggles
    //
    // ----------------------------------------------------------------------

    final theme = context.watch<ThemeController>();

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Namma Gadag',

      ////////////////////////////////////////////////////////////////////////
      /// 🌞 LIGHT THEME
      ////////////////////////////////////////////////////////////////////////
      theme: _buildLightTheme(),

      ////////////////////////////////////////////////////////////////////////
      /// 🌙 DARK THEME
      ////////////////////////////////////////////////////////////////////////
      darkTheme: _buildDarkTheme(),

      ////////////////////////////////////////////////////////////////////////
      /// 🔁 THEME MODE SWITCHER
      ////////////////////////////////////////////////////////////////////////
      themeMode:
      theme.isDark ? ThemeMode.dark : ThemeMode.light,

      ////////////////////////////////////////////////////////////////////////
      /// 🚀 FIRST SCREEN – SPLASH
      ////////////////////////////////////////////////////////////////////////
      home: const SplashScreen(),

    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// 🌞 LIGHT THEME
///////////////////////////////////////////////////////////////////////////////
///
/// ✅ Soft pastel background
/// ✅ Purple primary + Gold highlight
/// ✅ Rich typography
/// ✅ Designed specifically for tourist content reading
///
///////////////////////////////////////////////////////////////////////////////

ThemeData _buildLightTheme() {

  return ThemeData(

    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xFFF8F6FF),

    // ----------------------------------------------------------------------
    // 🎨 COLOR SCHEME
    // ----------------------------------------------------------------------

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
      primary: Colors.deepPurple,
      secondary: Colors.orange,
    ),

    // ----------------------------------------------------------------------
    // ⭐ APP BAR STYLING
    // ----------------------------------------------------------------------

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 8,

      titleTextStyle: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: Colors.amber,
        letterSpacing: 1.1,
        shadows: [
          Shadow(
            blurRadius: 6,
            color: Colors.black45,
            offset: Offset(2,2),
          ),
        ],
      ),

      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),

    // ----------------------------------------------------------------------
    // 📝 TYPOGRAPHY — RICH TEXT READY
    // ----------------------------------------------------------------------
    //
    // These fonts are used for:
    // • Place titles
    // • Descriptions
    // • Cards
    // • Audio captions
    //

    textTheme: const TextTheme(

      // Large Title → Place Name
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Colors.deepPurple,
      ),

      // Body → Long Description
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.65,
        color: Colors.black87,
      ),

      // Small text → subtitles / captions
      bodySmall: TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Colors.black54,
      ),
    ),

    // ----------------------------------------------------------------------
    // 🔘 ELEVATED BUTTONS
    // ----------------------------------------------------------------------

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(

        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,

        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 28,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),

        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    ),

    // ----------------------------------------------------------------------
    // 💬 SNACKBAR UI (Favorites, Audio Feedback)
    // ----------------------------------------------------------------------

    snackBarTheme: SnackBarThemeData(

        backgroundColor: Colors.deepPurple,

        contentTextStyle: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        behavior: SnackBarBehavior.floating),
  );
}

///////////////////////////////////////////////////////////////////////////////
/// 🌙 DARK THEME
///////////////////////////////////////////////////////////////////////////////
///
/// ✅ AMOLED black background
/// ✅ Gold titles
/// ✅ High-contrast text for readability at night
///
///////////////////////////////////////////////////////////////////////////////

ThemeData _buildDarkTheme() {

  return ThemeData(

    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
      primary: Colors.deepPurple,
      secondary: Colors.orange,
    ),

    appBarTheme: const AppBarTheme(

      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 8,

      titleTextStyle: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: Colors.amber,
        letterSpacing: 1,
      ),

      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),

    textTheme: const TextTheme(

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.amber,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.65,
        color: Colors.white,
      ),

      bodySmall: TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Colors.white70,
      ),
    ),
  );
}
