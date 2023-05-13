import 'dart:ffi';

import 'package:crm_game_joy/domain/model/activity.dart';
import 'package:dio/dio.dart';

import '../../model/activities.dart';
import 'api.dart';

class ApiActivity extends Api{

  Future<List<Activity>?> getActivities(String start, String end) async {

    final response = await dio.get(
      '/api/activities',
      options: Options(
        followRedirects: false,
      ),
      queryParameters: {
        "startDate":start,
        "endDate":end,
      }
    );
    return Activities.fromJson(response.data).activities;

  }
}
