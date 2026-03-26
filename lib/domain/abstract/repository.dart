import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/utils/result.dart';

abstract class Repository<T> {
  Future<Result<void>> add(T data);
  Future<Result<void>> addAll(List<T> data);
  Future<Result<void>> update(T data);
  Future<Result<void>> updateAll(List<T> data);
  Future<Result<void>> delete(T data);
  Future<Result<void>> deleteAll(List<T> data);
  Future<Result<List<T>>> getAll();
  Future<Result<T?>> getById(String data);
}

abstract class FileRepository {
  Future<Result<String>> insert(ImageModel data);
  Future<Result<List<String>>> insertAll(List<ImageModel> data);
  Future<Result<void>> delete(String id);
  Future<Result<void>> deleteAll(String id);
}

abstract class LocalRepository<T, R, W> implements Repository<T> {

  // --- DAO operations ---
  Future<List<R>> fetchAll();
  Future<R?> fetchById(String id);
  Future<void> insertModel(W model);
  Future<void> updateModel(W model);
  Future<void> removeModel(W model);

  // --- Lifecycle hooks (optional overrides) ---

  Future<void> onAfterInsert(T entity) async {}
  Future<void> onBeforeDelete(T entity) async {}

  // --- Mapping ---
  String idOf(R model);
  String entityIdOf(T entity);

  W toWriteModel(T entity);
  T toEntity(R model);

  // --- CRUD ---
  @override
  Future<Result<List<T>>> getAll() async {
    try {
      final models = await fetchAll();
      final res = await models.map((m) async => toEntity(m)).wait;
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
      return Result.ok(toEntity(model));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> add(T data) async {
    try {
      await insertModel(toWriteModel(data));

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
      await delete(data);

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
