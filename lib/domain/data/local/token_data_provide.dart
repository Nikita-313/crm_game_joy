import 'package:shared_preferences/shared_preferences.dart';

import 'data_provider_keys.dart';

class TokenDataProvider{

  void saveAuthToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(DataProviderKeys.token, token);
  }

  Future<String?> getAuthToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(DataProviderKeys.token);
  }

}