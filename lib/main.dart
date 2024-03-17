import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vitrine/data/enviroment/authentication/authentication_enviroment.dart';
import 'package:vitrine/main/factory/enviroment/authentication_enviroment.dart';
import 'package:vitrine/ui/authentication/authentication_page.dart';
import 'package:vitrine/ui/design/text_theme.dart';
import 'package:vitrine/ui/main/main_page.dart';
import 'package:vitrine/ui/onboarding_page/onboarding_page.dart';
import 'package:vitrine/ui/product/add_product_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Method 3
Future _showNotificationWithoutSound() async {
  await flutterLocalNotificationsPlugin.show(
    0,
    'Olá',
    'Bem vindo ao Vitrine',
    null,
    payload: 'No_Sound',
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  _showNotificationWithoutSound();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<FirebaseApp> get _initialization => Firebase.initializeApp();
  final enviroment = AuthenticationEnviromentFactory.factory;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vitrine",
      theme: ThemeData(textTheme: textTheme),
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth': (context) => AuthenticationPage(),
        '/home': (context) => MainPage(),
        '/add-product': (context) => AddProductPage(),
      },
      home: FutureBuilder(
        future: _initialization,
        builder: (context, initializationSnapshot) {
          if (initializationSnapshot.hasError) {
            return const Text("error? rs"); // TODO: Add an error screen
          }

          if (initializationSnapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<AuthenticationState>(
              stream: enviroment.authenticationState,
              builder: (context, snapshot) {
                if (snapshot.data == AuthenticationState.loggedIn) {
                  return MainPage();
                } else {
                  return OnboardingPage();
                }
              },
            );
          }
          return const Text("carregando? rs"); // TODO: Add a loading screen
        },
      ),
    );
  }
}
