import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/data/services/authentication/authentication_service.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: VanillaColorScheme.dark,
        borderRadius: 30,
        currentIndex: 0,
        selectedBackgroundColor: null,
        unselectedItemColor: VanillaColorScheme.medium,
        selectedItemColor: VanillaColorScheme.secondary,
        width: 303,
        iconSize: 28,
        onTap: (int index) {},
        items: [
          FloatingNavbarItem(icon: Icons.home),
          FloatingNavbarItem(icon: Icons.search),
          FloatingNavbarItem(icon: Icons.shopping_bag),
          FloatingNavbarItem(icon: Icons.archive),
          FloatingNavbarItem(icon: Icons.person),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            AuthenticationService().logout();
          },
          child: const Text("Sair"),
        ),
      ),
    );
  }
}
