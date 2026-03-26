import 'package:meal_planner/data/local/dao/image.dao.dart';
import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

class LocalFileRepository implements FileRepository {
  final ImageDAO _imageDAO;
  final FileStorageService _fileStorageService;

  LocalFileRepository({required ImageDAO imageDAO, required FileStorageService fileStorageService}) : _imageDAO = imageDAO, _fileStorageService = fileStorageService;

  @override
  Future<Result<String>> insert(ImageModel data) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>>> insertAll(List<ImageModel> data) {
    // TODO: implement insertAll
    throw UnimplementedError();
  }
  @override
  Future<Result<void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteAll(String id) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }


}
 

