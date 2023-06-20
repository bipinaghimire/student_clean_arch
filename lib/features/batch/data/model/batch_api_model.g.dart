// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchApiModel _$BatchApiModelFromJson(Map<String, dynamic> json) =>
    BatchApiModel(
      batchId: json['id'] as String?,
      batchName: json['batchName'] as String,
    );

Map<String, dynamic> _$BatchApiModelToJson(BatchApiModel instance) =>
    <String, dynamic>{
      'id': instance.batchId,
      'batchName': instance.batchName,
    };
