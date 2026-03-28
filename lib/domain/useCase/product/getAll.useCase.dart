import 'dart:io';

import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/utils/result.dart';

import '../../abstract/repository.dart';
import '../../entities/product/product.entity.dart';

class GetAllProductUseCase extends GetAllUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  GetAllProductUseCase({
    required super.repository,
    required FileRepository fileRepository,
  }) : _fileRepository = fileRepository;

  @override
  Future<Result<List<ProductEntity>>> call({required void data}) async {
    final res = await super.call(data: data);

    switch (res) {
      case Ok<List<ProductEntity>>(value: final data):
        if(data.isEmpty) return Result.ok(data);
        final products = await Future.wait(
          data.map((product) async {
            final images = await _fileRepository.getAll(product.id);

            switch (images) {
              case Ok<List<File>>(value: final fileList):
                return product.copyWith(images: fileList);

              case Error<List<File>>():
                return product; // Return product without images gracefully
            }
          }),
        );

        return Result.ok(products);

      case Error<List<ProductEntity>>():
        return Result.error(
          res.error,
        ); // or Result.error(...) depending on your design
    }
  }
}
