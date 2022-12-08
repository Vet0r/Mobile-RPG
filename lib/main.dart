import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/buttons_chose.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import 'init_button.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Erro");
          } else if (snapshot.hasData) {
            return MyHomePage(title: 'Flutter Demo Home Page');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            theme: darkThemeDataCustom,
            home: SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
            ),
          );
        }
        return ButtonsChose(
          userData: snapshot.data!,
        );
      },
    );
  }
}

final ThemeData darkThemeDataCustom = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(24),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(CustomTeheme.buttons70),
        foregroundColor:
            MaterialStateProperty.all<Color>(CustomTeheme.background),
      ),
    ),
    colorScheme: darkColorScheme,
    primaryColor: darkColorScheme.primary,
    scaffoldBackgroundColor: darkColorScheme.background,
  );
}

var darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFADC6FF),
  onPrimary: Color(0xFF002E69),
  secondary: Color(0xFFBBC6E4),
  onSecondary: Color(0xFF253048),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  background: CustomTeheme.background,
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF1B1B1F),
  onSurface: Color(0xFFE3E2E6),
);
