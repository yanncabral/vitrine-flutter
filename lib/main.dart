import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitrine/data/enviroment/authentication/authentication_enviroment.dart';
import 'package:vitrine/main/factory/enviroment/authentication_enviroment.dart';
import 'package:vitrine/ui/authentication/authentication_page.dart';
import 'package:vitrine/ui/design/text_theme.dart';
import 'package:vitrine/ui/home_page/home_page.dart';
import 'package:vitrine/ui/onboarding_page/onboarding_page.dart';

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
  late final authenticationEnviroment = AuthenticationEnviromentFactory.factory;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vitrine",
      theme: ThemeData(textTheme: textTheme),
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth': (context) => AuthenticationPage(),
        '/home': (context) => HomePage(),
      },
      home: FutureBuilder(
        future: _initialization,
        builder: (context, initializationSnapshot) {
          if (initializationSnapshot.hasError) {
            return const Text("error? rs"); // TODO: Add an error screen
          }

          if (initializationSnapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<AuthenticationState>(
                stream: authenticationEnviroment.authenticationState,
                builder: (context, snapshot) {
                  return snapshot.data == AuthenticationState.loggedIn
                      ? HomePage()
                      : OnboardingPage();
                });
          }
          return const Text("carregando? rs"); // TODO: Add a loading screen
        },
      ),
    );
  }
}
