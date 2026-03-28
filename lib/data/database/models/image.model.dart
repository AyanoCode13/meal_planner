import 'package:floor/floor.dart';
@Entity(tableName: 'images', primaryKeys: ['url', 'id'])
class ImageModel {
  final String id;
  final String url;
  bool? isThumbnail = false;

  ImageModel({required this.id, required this.url, this.isThumbnail});
  
}