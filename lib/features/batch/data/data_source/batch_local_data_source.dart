import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/core/failure/failure.dart';
import 'package:student_clean_arch/core/network/local/hive_service.dart';
import 'package:student_clean_arch/features/batch/data/model/batch_hive_model.dart';
import 'package:student_clean_arch/features/batch/domain/entity/batch_entity.dart';

final batchLocalDataSourceProvider = Provider(
  (ref) => BatchLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      batchHiveModel: ref.read(
        batchHiveModelProvider,
      )),
);

class BatchLocalDataSource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel,
  });

  // Add batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      //convert entity to hive object
      final hiveBatch = batchHiveModel.toHiveModel(batch);
      // Add to hive
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  //get all batch
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      //get all batches from hive
      final batches = await hiveService.getAllBatches();
      // convert hive object into entity
      final batchEntities = batchHiveModel.toEntityList(batches);
      return Right(batchEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
