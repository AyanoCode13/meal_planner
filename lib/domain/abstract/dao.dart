



abstract class DAO<I,O> {
  Future<List<O>> findAll();
  Future<O?> findById(String id);
  Future<void> insert(I data);
  Future<void> insertAll(List<I> data);
  Future<void> update(I data);
  Future<void> updateAll(List<I> data);
  Future<void> remove(I id);
  Future<void> removeAll(List<I> data);
}


