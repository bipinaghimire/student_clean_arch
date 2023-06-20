import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_clean_arch/features/batch/domain/entity/batch_entity.dart';

// dart run build_runner build --delete-conflicting-outputs
part 'batch_api_model.g.dart';

final batchApiModelProvider = Provider<BatchApiModel>(
  (ref) => const BatchApiModel.empty(),
);

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    required this.batchId,
    required this.batchName,
  });
  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  Map<String, dynamic> toJson() => _$BatchApiModelToJson(this);

  factory BatchApiModel.fromJson(Map<String, dynamic> json) =>
      _$BatchApiModelFromJson(json);

  // Convert API Object to Entity
  BatchEntity toEntity() => BatchEntity(
        batchId: batchId,
        batchName: batchName,
      );

  // Convert Entity to API Object
  BatchApiModel fromEntity(BatchEntity entity) => BatchApiModel(
        batchId: entity.batchId ?? '',
        batchName: entity.batchName,
      );

  // Convert API List to Entity List
  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [batchId, batchName];
}
