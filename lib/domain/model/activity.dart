import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  String? sId;
  String? name;

  //List<Users>? users;
  List<String>? cities;
  String? format;
  String? type;
  String? date;
  String? description;
  int? costPerParticipant;
  int? transferCost;
  int? iV;

  Activity({this.sId,
    this.description,
    this.cities,
    this.name,
    //this.users,
    this.format,
    this.type,
    this.date,
    this.costPerParticipant,
    this.transferCost,
    this.iV});

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
