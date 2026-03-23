import 'dart:io';

import 'package:path_provider/path_provider.dart';

final class FileStorageService {
  const FileStorageService();
  Future<Directory> _getBaseDir() async {
    return await getApplicationDocumentsDirectory();
  }

  Future<String> saveFile({required File file, required String folder}) async {
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

  Future<File?> getFile({required String folder, required String fileName}) async {
    final baseDir = await _getBaseDir();
    final path = '${baseDir.path}/$folder/$fileName';
    print("File path: $path");
    final file = File(path);
    return await file.exists() ? file : null;
  }

  Future<void> deleteFiles({required String folder}) async {
    final baseDir = await _getBaseDir();
    final targetDir = Directory('${baseDir.path}/$folder');
    await targetDir.delete(recursive: true);
  }
}
