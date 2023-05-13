import 'activity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'activities.g.dart';

@JsonSerializable()
class Activities {
  List<Activity>? activities;

  Activities({this.activities});

  factory Activities.fromJson(Map<String, dynamic> json) => _$ActivitiesFromJson(json);
  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);

}