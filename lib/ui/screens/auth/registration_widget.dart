import 'package:flutter/material.dart';

class RegistrationWidget extends StatelessWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Column(
        children: const [
          Text("Регистрация"),
          _FullNameForm(),
        ],
      ),
    );
  }
}


class _FullNameForm extends StatelessWidget {
  const _FullNameForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(
            label: Text("ФИО")
          ),
        ),
      ],
    );
  }
}

