// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      sId: json['sId'] as String?,
      description: json['description'] as String?,
      cities:
          (json['cities'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      format: json['format'] as String?,
      type: json['type'] as String?,
      date: json['date'] as String?,
      costPerParticipant: json['costPerParticipant'] as int?,
      transferCost: json['transferCost'] as int?,
      iV: json['iV'] as int?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'sId': instance.sId,
      'name': instance.name,
      'cities': instance.cities,
      'format': instance.format,
      'type': instance.type,
      'date': instance.date,
      'description': instance.description,
      'costPerParticipant': instance.costPerParticipant,
      'transferCost': instance.transferCost,
      'iV': instance.iV,
    };
