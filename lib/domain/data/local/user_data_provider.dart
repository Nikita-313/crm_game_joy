import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user.dart';
import 'data_provider_keys.dart';

class UserDataProvider{

  void saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(DataProviderKeys.userID, user.id);
    await prefs.setString(DataProviderKeys.userEmail, user.email);
  }
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    var userID = prefs.getString(DataProviderKeys.userID);
    var userEmail = prefs.getString(DataProviderKeys.userEmail);

    if (userID == null || userEmail == null ) return null;

    return User(id: userID, email: userEmail);
  }

}