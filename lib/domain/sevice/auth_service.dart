import 'package:crm_game_joy/domain/data/local/token_data_provide.dart';
import 'package:crm_game_joy/domain/data/local/user_data_provider.dart';
import 'package:crm_game_joy/domain/data/newtwork/api_auth.dart';
import '../model/auth.dart';

class AuthService {
  final _apiAuth = ApiAuth();
  final _tokenDataProvider = TokenDataProvider();
  final _userDataProvider = UserDataProvider();

  Future<void> auth(String email) async {
    Auth authData = await _apiAuth.login(email);
    _tokenDataProvider.saveAuthToken(authData.accessToken);
    _userDataProvider.saveUser(authData.user);
  }

  Future<bool> isAuth() async {
    var user = await _userDataProvider.getUser();
    return user != null;
  }
}
