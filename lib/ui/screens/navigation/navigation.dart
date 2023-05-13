import 'package:crm_game_joy/ui/screens/auth/auth_widger.dart';
import 'package:crm_game_joy/ui/screens/auth/registration_widget.dart';
import 'package:crm_game_joy/ui/screens/home/home_widget.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRoutsName {
  static const auth = '/auth';
  static const home = '/home';
  static const activity = '/activity/create';
  static const personArea = '/personArea';
  static const registration = '/registration';
  static const voting = '/voting/create';
}

class MainNavigation {
  final initialRout = MainNavigationRoutsName.home;
  final routs = {
    MainNavigationRoutsName.auth: (BuildContext context) => const AuthWidget(),
    MainNavigationRoutsName.home: (BuildContext context) => const HomeWidget(),
    MainNavigationRoutsName.registration: (BuildContext context) =>
        const RegistrationWidget(),
  };
}
