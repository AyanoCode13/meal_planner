import 'package:floor/floor.dart';
@Entity(tableName: 'images', primaryKeys: ['url', 'id'])
class ImageModel {
  final String id;
  final String url;
  final bool isThumbnail;

  ImageModel({required this.id, required this.url, required this.isThumbnail});
  
}