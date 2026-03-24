import 'dart:io';

import 'package:meal_planner/data/local/dao/image.dao.dart';
import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

abstract class Repository<T> {
  Future<Result<void>> add(T data);
  Future<Result<List<void>>> addAll(List<T> data);
  Future<Result<void>> update(T data);
  Future<Result<List<void>>> updateAll(List<T> data);
  Future<Result<void>> delete(T data);
  Future<Result<List<void>>> deleteAll(List<T> data);
  Future<Result<List<T>>> getAll();
  Future<Result<T?>> getById(String data);
}


abstract class LocalRepository<T, R, W> implements Repository<T> {
  final ImageDAO _imageDAO;
  final FileStorageService _fileStorageService;

  LocalRepository({
    required ImageDAO imageDAO,
    required FileStorageService fileStorageService,
  })  : _imageDAO = imageDAO,
        _fileStorageService = fileStorageService;

  // --- DAO operations ---
  Future<List<R>> fetchAll();
  Future<R?> fetchById(String id);
  Future<void> insertModel(W model);
  Future<void> updateModel(W model);
  Future<void> removeModel(W model);

  // --- Mapping ---
  String idOf(R model);
  String entityIdOf(T entity);
  List<File?> imagesOf(T entity);
  W toWriteModel(T entity);
  T toEntity(R model, List<File?> images);

  // --- Lifecycle hooks (optional overrides) ---
  Future<void> onAfterInsert(T entity) async {}
  Future<void> onBeforeDelete(T entity) async {}

  // --- Private helpers ---
  Future<List<File?>> _loadImages(String ownerId) async {
    final images = await _imageDAO.findByOwner(ownerId);
    return images
        .map((i) async => _fileStorageService.getFile(
              folder: ownerId,
              fileName: i.url,
            ))
        .wait;
  }

  Future<void> _saveImages(T entity) async {
    final id = entityIdOf(entity);
    final urls = await imagesOf(entity)
        .map((i) async => _fileStorageService.saveFile(file: i!, folder: id))
        .wait;
    await _imageDAO.insertAll(
      urls.map((u) => ImageModel(id: id, url: u, isThumbnail: false)).toList(),
    );
  }

  // --- CRUD ---
  @override
  Future<Result<List<T>>> getAll() async {
    try {
      final models = await fetchAll();
      final res = await models
          .map((m) async => toEntity(m, await _loadImages(idOf(m))))
          .wait;
      return Result.ok(res);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<T?>> getById(String id) async {
    try {
      final model = await fetchById(id);
      if (model == null) return Result.ok(null);
      return Result.ok(toEntity(model, await _loadImages(idOf(model))));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> add(T data) async {
    try {
      await (insertModel(toWriteModel(data)), _saveImages(data)).wait;
      await onAfterInsert(data);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<void>>> addAll(List<T> data) async {
    try {
      return Result.ok(await data.map((e) async => add(e)).wait);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> update(T data) async {
    try {
      return Result.ok(await updateModel(toWriteModel(data)));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<void>>> updateAll(List<T> data) async {
    try {
      return Result.ok(await data.map((e) async => update(e)).wait);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> delete(T data) async {
    try {
      await onBeforeDelete(data);
      final id = entityIdOf(data);
      await (
        _imageDAO.deleteFromOwner(id),
        _fileStorageService.deleteFiles(folder: id),
        removeModel(toWriteModel(data)),
      ).wait;
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<void>>> deleteAll(List<T> data) async {
    try {
      return Result.ok(await data.map((e) async => delete(e)).wait);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}