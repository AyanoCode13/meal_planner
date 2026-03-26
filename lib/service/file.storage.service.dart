import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageService {
  const FileStorageService();
  Future<Directory> _getBaseDir() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<String> save({required File file, required String folder}) async {
    final baseDir = await _getBaseDir();
    final targetDir = Directory('${baseDir.path}/$folder');
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final newPath = '${targetDir.path}/${file.path.split('/').last}';
    print("Saving file to: $newPath");
    file = await file.copy(newPath);
    final filename = newPath.split("/").last;
    print("File saved with name: $filename");
    return filename;
  }

  Future<List<String>> saveAll({
    required List<File> files,
    required String folder,
  }) async {
    final paths = <String>[];
    for (final file in files) {
      final path = await save(file: file, folder: folder);
      paths.add(path);
    }
    return paths;
  }

  Future<File?> get({required String folder, required String fileName}) async {
    final baseDir = await _getBaseDir();
    final path = '${baseDir.path}/$folder/$fileName';
    print("File path: $path");
    final file = File(path);
    return await file.exists() ? file : null;
  }

  Future<List<File>> getAll({required String folder}) async {
    final baseDir = await _getBaseDir();
    final dir = Directory('${baseDir.path}/$folder');

    if (!await dir.exists()) return [];

    return dir
        .listSync()
        .whereType<File>() // ← excludes subdirectories
        .toList();
  }

  Future<void> delete({
    required String folder,
    required String fileName,
  }) async {
    final baseDir = await _getBaseDir();
    final targetDir = Directory('${baseDir.path}/$folder');
    await targetDir.delete(recursive: true);
  }

  Future<void> deleteAll({required String folder}) async {
    final baseDir = await _getBaseDir();
    final targetDir = Directory('${baseDir.path}/$folder');
    await targetDir.delete(recursive: true);
  }
}
