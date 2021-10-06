import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/ui/authentication/authentication_page.dart';
import 'package:vitrine/ui/design/text_theme.dart';
import 'package:vitrine/ui/main/main_page.dart';
import 'package:vitrine/ui/onboarding_page/onboarding_page.dart';
import 'package:vitrine/ui/product/add_product_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<FirebaseApp> get _initialization => Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vitrine",
      theme: ThemeData(textTheme: textTheme),
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth': (context) => AuthenticationPage(),
        '/home': (context) => MainPage(),
      },
      home: FutureBuilder(
        future: _initialization,
        builder: (context, initializationSnapshot) {
          if (initializationSnapshot.hasError) {
            return const Text("error? rs"); // TODO: Add an error screen
          }

          if (initializationSnapshot.connectionState == ConnectionState.done) {
            return AddProductPage();
          }
          return const Text("carregando? rs"); // TODO: Add a loading screen
        },
      ),
    );
  }
}
