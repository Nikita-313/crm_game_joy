import 'package:crm_game_joy/ui/app/crm_game_joy_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  //runApp(const CrmGameJoyApp());
  initializeDateFormatting().then((_) => runApp(const CrmGameJoyApp()));
}
