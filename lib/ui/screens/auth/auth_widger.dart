import 'dart:io';

import 'package:crm_game_joy/domain/sevice/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  final authService = AuthService();
  String email = '';
  String errorMassage = '';

  void auth() {
    try {
      if (email.isNotEmpty) {
        authService.auth(email);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400) {
          errorMassage = 'Не зарегистрированная почта';
        }
      }
      if (e is SocketException) {
        errorMassage = 'Сервер не доступен, проверьте подключение к серверу';
      }
      errorMassage = 'Неизвестная ошибка';
      notifyListeners();
    }
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Авторизация"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _ErrorTitle(),
              _EmailForm(),
              SizedBox(height: 10,),
              _AuthButton(),
            ],
          ),
        ));
  }

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: const AuthWidget(),
    );
  }
}

class _ErrorTitle extends StatelessWidget {
  const _ErrorTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<_ViewModel>();
    return Text(
      vm.errorMassage,
      style: const TextStyle(color: Colors.red),
    );
  }
}

class _EmailForm extends StatelessWidget {
  const _EmailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<_ViewModel>();
    return SizedBox(
      width: 300,
      child: TextField(
        onChanged: (text) {
          vm.email = text;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Email"),
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  const _AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<_ViewModel>();
    return OutlinedButton(
        onPressed: vm.auth, child: const Text("Авторизоваться"));
  }
}
