import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/image.model.dart';

@dao
abstract class ImageDAO {
  @Query('SELECT * FROM images')
  Future<List<ImageModel>> findAll();

  @Query('SELECT * FROM images WHERE id = :id')
  Future<List<ImageModel>> findByOwner(String id);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insert(ImageModel data);

  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertAll(List<ImageModel> data);

  @delete
  Future<void> remove(ImageModel data);

  @delete
  Future<void> removeAll(List<ImageModel> data);
}
