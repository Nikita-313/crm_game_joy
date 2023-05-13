
import 'package:crm_game_joy/domain/model/auth.dart';
import 'package:dio/dio.dart';
import 'api.dart';

class ApiAuth extends Api {

  final dio1 = Dio();

  Future<Auth> login(String email) async {
    final response = await dio.post(
        '/api/auth/login',
      data: {'email': email},
    );
    return Auth.fromJson(response.data);
  }

}
