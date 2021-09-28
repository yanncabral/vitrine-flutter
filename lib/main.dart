import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/text_theme.dart';
import 'package:vitrine/ui/onboarding_page/onboarding_page.dart';
import 'package:vitrine/ui/signin_page.dart';

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
        '/auth': (context) => SignInPage(),
      },
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error? rs"); // TODO: Add an error screen
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // return SignInPage();
            return OnboardingPage();
          }
          return const Text("carregando? rs"); // TODO: Add a loading screen
        },
      ),
    );
  }
}
