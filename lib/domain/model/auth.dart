import 'package:crm_game_joy/domain/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()

class Auth {
  final  String accessToken;
  final  User user;

  Auth({
    required this.user,
    required this.accessToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);

}
