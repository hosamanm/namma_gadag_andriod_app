import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_controller.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int index = 0;

  final pages = const [
    HomeScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(index == 0 ? "Tourist Places" : "Favorites"),
        actions: [
          IconButton(
            icon: Icon(
              theme.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () =>
                context.read<ThemeController>().toggleTheme(),
          ),
        ],
      ),

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.deepPurple,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Places",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
