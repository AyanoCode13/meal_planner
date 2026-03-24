import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/image.model.dart';

@dao
abstract class ImageDAO {
  @Query('SELECT * FROM images')
  Future<List<ImageModel>> findAll();

  @Query('SELECT * FROM images WHERE id = :ownerId')
  Future<List<ImageModel>> findByOwner(String ownerId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ImageModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<ImageModel> data);

  @Query('DELETE * FROM images WHERE id = :ownerId')
  Future<void> deleteFromOwner(String ownerId);
}
