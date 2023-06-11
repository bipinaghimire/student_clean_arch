import 'package:hive/hive.dart';
import 'package:student_clean_arch/config/constants/hive_table_constant.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/batch_entity.dart';

// dart run build_runner build --delete-conflicting-outputs
part 'batch_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

  //empty constructor
  BatchHiveModel.empty() : this(batchId: "", batchName: "");

  BatchHiveModel({
    String? batchId,
    required this.batchName,
  }) : batchId = batchId ?? const Uuid().v4();

  @override
  String toString() => 'BatchEntity(batchId: $batchId, batchName: $batchName)';

  //convert hive object to entity

  BatchEntity toEntity() => BatchEntity(batchId: batchId, batchName: batchName);

  //covert entity into hive object
  BatchHiveModel toHiveModel(BatchEntity entity) => BatchHiveModel(
        //batchId: batachId
        batchName: entity.batchName,
      );

  // Convert hive list to entity list
  List<BatchEntity> toEntityList(List<BatchHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
