import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';
import 'package:vitrine/ui/home/home_page.dart';
import 'package:vitrine/ui/main/bottom_navbar_tabs.dart';
import 'package:vitrine/ui/profile/profile_page.dart';

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
        centerTitle: false,
        actions: _currentNavbarTab == BottomNavbarTabs.profile
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircleAvatar(
                    backgroundColor: VanillaColorScheme.medium.withOpacity(0.1),
                    child: IconButton(
                      color: VanillaColorScheme.secondary,
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/add-product"),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
              ]
            : [],
        title: Text(_currentNavbarTab.title),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
        items: BottomNavbarTabs.values.map((e) {
          switch (e) {
            case BottomNavbarTabs.home:
              return FloatingNavbarItem(icon: Icons.home);
            case BottomNavbarTabs.search:
              return FloatingNavbarItem(icon: Icons.search);
            case BottomNavbarTabs.archived:
              return FloatingNavbarItem(icon: Icons.archive);
            case BottomNavbarTabs.profile:
              return FloatingNavbarItem(icon: Icons.person);
          }
        }).toList(),
      ),
      extendBody: true,
      body: PageView.builder(
        onPageChanged: (int index) => setState(() {
          _currentNavbarTab = BottomNavbarTabs.values[index];
        }),
        itemCount: BottomNavbarTabs.values.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          final page = BottomNavbarTabs.values[index];
          switch (page) {
            case BottomNavbarTabs.home:
              return HomePage();
            case BottomNavbarTabs.search:
              return const Center(child: Text("Search"));
            case BottomNavbarTabs.archived:
              return const Center(child: Text("Archive"));
            case BottomNavbarTabs.profile:
              return const ProfilePage();
          }
        },
      ),
    );
  }
}
