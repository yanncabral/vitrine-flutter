import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitrine/data/services/authentication/authentication_service.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/main/bottom_navbar_tabs.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavbarTabs _currentNavbarTab = BottomNavbarTabs.values[0];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text(_currentNavbarTab.title),
          ],
        ),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline3
            ?.copyWith(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
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
      extendBody: true,
      body: Container(
        color: Colors.red,
        child: PageView.builder(
          onPageChanged: (int index) => setState(() {
            _currentNavbarTab = BottomNavbarTabs.values[index];
          }),
          itemCount: BottomNavbarTabs.values.length,
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
      ),
    );
  }
}
