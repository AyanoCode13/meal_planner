

abstract class Repository<T> {
  Future<void> add(T input);
  Future<void> update(T input);
  Future<void> delete(String id);
  Future<List<T>> getAll();
  Future<T?> getById(String id);
}