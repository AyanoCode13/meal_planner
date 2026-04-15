import 'dart:io';

import 'package:meal_planner/data/database/dao/image.dao.dart';
import 'package:meal_planner/data/database/models/image.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

class LocalFileRepository implements FileRepository {
  final ImageDAO _imageDAO;
  final FileStorageService _fileStorageService;

  LocalFileRepository({
    required ImageDAO imageDAO,
    required FileStorageService fileStorageService,
  }) : _imageDAO = imageDAO,
       _fileStorageService = fileStorageService;

  @override
  Future<Result<String>> insert(ImageModel data) async {
    // TODO: implement insert
    try {
      await _imageDAO.insert(data);
      final res = await _fileStorageService.save(
        folder: data.id,
        file: File(data.url),
      );
      return Result.ok(res);
    } on Exception catch (e) {
      await _imageDAO.insert(data);
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<String>>> insertAll(List<ImageModel> data) async {
    // TODO: implement insertAll
    if(data.isEmpty) return Result.ok([]);
    try {
      await _imageDAO.insertAll(data);
      final files = data.map((e) => File(e.url)).toList();
      final paths = await _fileStorageService.saveAll(
        files: files,
        folder: data[0].id,
      );
      return Result.ok(paths);
    } on Exception catch (e) {
      await _imageDAO.removeAll(data);
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> delete(ImageModel data) async {
    // TODO: implement delete
    try {
      final res = await _imageDAO.remove(data);
      await _fileStorageService.delete(folder: data.id, fileName: data.url);
      return Result.ok(res);
    } on Exception catch (e) {
      await _imageDAO.insert(data);
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteAll(List<ImageModel> data) async {
    // TODO: implement deleteAll
    if(data.isEmpty) return Result.ok(null);
    try {
      final res = await _imageDAO.removeAll(data);
      await _fileStorageService.deleteAll(folder: data[0].id);
      return Result.ok(res);
    } on Exception catch (e) {
      await _imageDAO.insertAll(data);
      return Result.error(e);
    }
  }

  @override
  Future<Result<File?>> get(String folder, String fileName) async {
    // TODO: implement get
    try {
      final res = await _fileStorageService.get(
        folder: folder,
        fileName: fileName,
      );
      if (res != null) return Result.ok(res);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<File>>> getAll(String folder) async {
    // TODO: implement getAll
    try {
      final res = await _fileStorageService.getAll(folder: folder);
      return Result.ok(res);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

