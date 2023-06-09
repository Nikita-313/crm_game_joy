import 'package:crm_game_joy/ui/screens/navigation/navigation.dart';
import 'package:flutter/material.dart';

class CrmGameJoyApp extends StatelessWidget {
  const CrmGameJoyApp({super.key});
  static final mainNavigation = MainNavigation();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFFF86161),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF86161),
        )
      ),
      initialRoute: mainNavigation.initialRout,
      routes: mainNavigation.routs,
    );
  }
}