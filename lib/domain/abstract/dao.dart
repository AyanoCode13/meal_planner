
abstract class DAO<T> {
  Future<List<T>> findAll();
  Future<T?> findById(String id);
  Future<void> insert(T data);
  Future<void> insertMany(List<T> data);
  Future<void> update(T data);
  Future<void> updateMany(List<T> data);
  Future<void> delete(String id);
  Future<void> deleteMany(List<T> data);
}
