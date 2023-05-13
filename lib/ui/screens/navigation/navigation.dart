import 'package:crm_game_joy/ui/screens/auth/auth_widger.dart';
import 'package:crm_game_joy/ui/screens/home/home_widget.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRoutsName {
  static const auth = '/auth';
  static const home = '/home';
  static const activity = '/activity/create';
  static const personArea = '/personArea';
}

class MainNavigation {
  final initialRout = MainNavigationRoutsName.home;
  final routs = {
    MainNavigationRoutsName.auth: (BuildContext context) => AuthWidget.create(),
    MainNavigationRoutsName.home: (BuildContext context) => HomeWidget.create(),
  };
}
