import 'package:flutter/material.dart';
import 'package:vitrine/data/services/authentication/authentication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
