import 'dart:io';

import '../../../utils/result.dart';
import '../../abstract/repository.dart';
import '../../abstract/use_case.dart';
import '../../entities/product/product.entity.dart';

class GetByIdProductUseCase extends GetByIdUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  GetByIdProductUseCase({
    required super.repository,
    required FileRepository fileRepository,
  }) : _fileRepository = fileRepository;

  @override
  Future<Result<ProductEntity?>> call({required String data}) async {
    // TODO: implement call

    final res = await super.call(data: data);
    switch (res) {
      case Ok<ProductEntity?>():
        {
          final product = res.value;
          if (product != null) {
            final images = await _fileRepository.getAll(product.id);
            switch (images) {
              case Ok<List<File>>(value: final fileList):
                final productWithImages = product.copyWith(images: fileList);
                return Result.ok(productWithImages);

              case Error<List<File>?>():
                return Result.ok(product);
            }
          }
          return Result.ok(null);
        }
      case Error<ProductEntity?>():
        {
          return Result.ok(null);
        }
    }
  }
}
