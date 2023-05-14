import 'package:crm_game_joy/domain/sevice/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../navigation/navigation.dart';

class _ViewModel extends ChangeNotifier {
  final authService = AuthService();

  _ViewModel(BuildContext context) {
    checkAuth(context);
  }

  void checkAuth(BuildContext context) async {
    final res = await authService.isAuth();
    await Future.delayed(const Duration(seconds: 2));
    if (res) {
      Navigator.of(context).pushReplacementNamed(MainNavigationRoutsName.home);
    } else {
      Navigator.of(context).pushReplacementNamed(MainNavigationRoutsName.auth);
    }
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Joy dev"),
      ),
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(context),
      lazy: false,
      child: const SplashWidget(),
    );
  }
}
