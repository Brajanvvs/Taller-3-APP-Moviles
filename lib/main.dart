import 'package:flutter/material.dart';
import 'package:taller_corte_3/pages/CodeScreen.dart';
import 'package:taller_corte_3/pages/HomeScreen.dart';
import 'package:taller_corte_3/pages/LoginScreen.dart';
import 'package:taller_corte_3/pages/PasswordScreen.dart';
import 'package:taller_corte_3/pages/RecoverScreen.dart';
import 'package:taller_corte_3/pages/RegisterScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => LoginScreen(),
        "/registro": (_) => RegisterScreen(),
        "/recuperar": (_) => RecoverScreen(),
        "/codigo": (_) => CodeScreen(),
        "/clave-nueva": (_) => PasswordScreen(),
        "/inicio": (_) => HomeScreen(),
      },
    );
  }
}
