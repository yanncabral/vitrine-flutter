import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/data/services/authentication/authentication_service.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

enum BottomNavbarTabs {
  home,
  search,
  bag,
  archived,
  profile,
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavbarTabs _currentNavbarTab = BottomNavbarTabs.values[0];
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: VanillaColorScheme.dark,
        borderRadius: 30,
        currentIndex: _currentNavbarTab.index,
        selectedBackgroundColor: null,
        unselectedItemColor: VanillaColorScheme.medium,
        selectedItemColor: VanillaColorScheme.secondary,
        width: 303,
        iconSize: 28,
        onTap: (int index) => setState(() {
          _currentNavbarTab = BottomNavbarTabs.values[index];
          _pageController.animateToPage(
            _currentNavbarTab.index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
          );
        }),
        items: [
          FloatingNavbarItem(icon: Icons.home),
          FloatingNavbarItem(icon: Icons.search),
          FloatingNavbarItem(icon: Icons.shopping_bag),
          FloatingNavbarItem(icon: Icons.archive),
          FloatingNavbarItem(icon: Icons.person),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          final _page = BottomNavbarTabs.values[index];
          switch (_page) {
            case BottomNavbarTabs.home:
              return const Center(child: Text("Home"));
            case BottomNavbarTabs.search:
              return const Center(child: Text("Search"));
            case BottomNavbarTabs.bag:
              return const Center(child: Text("Bag"));
            case BottomNavbarTabs.archived:
              return const Center(child: Text("Archive"));
            case BottomNavbarTabs.profile:
              return Center(
                child: TextButton(
                  onPressed: () {
                    AuthenticationService().logout();
                  },
                  child: const Text("Sair"),
                ),
              );
          }
        },
      ),
    );
  }
}
