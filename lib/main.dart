import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projek/screens/awalan/landing_screen.dart';
import 'package:projek/screens/home/home_screen.dart';
import 'package:projek/screens/home/list_screen.dart';
import 'package:projek/tema/constant.dart';
import 'package:projek/tema/theme_app.dart';
import 'package:projek/tema/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:projek/tema/light_theme.dart';
import 'package:projek/tema/dark_theme.dart';
import 'package:projek/tema/theme_notifier.dart';
import 'package:projek/screens/awalan/daftar_screen.dart';
import 'package:projek/screens/awalan/masuk_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool(SPref.isLight) ?? true;

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  //  await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //  appleProvider: AppleProvider.appAttest,
  // );
   runApp(AppStart(
    isLightTheme: isLightTheme,
  ));
}
class AppStart extends StatelessWidget {
  const AppStart({super.key, required this.isLightTheme});
  final bool isLightTheme;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(isLightTheme: isLightTheme),
        ),
      ],
      child: const MainApp(),
    );
  }
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Logo Screen',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: theme.currentTheme,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User? user = snapshot.data;
                  return HomePage(
                    user: user,
                  );
                } else {
                  return const LandingScreen();
                }
              },
            ),
            initialRoute: '/',
            routes: {
              '/daftar': (context) => const DaftarScreen(),
              '/masuk': (context) => const MasukScreen(),
              '/tema': (context) => const TemaPage(),
            },
          );
        },
      ),
    );
  }
}
