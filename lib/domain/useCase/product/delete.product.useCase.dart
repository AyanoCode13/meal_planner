import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

import '../../../data/local/models/models.dart';
import '../../../utils/result.dart';
import '../../abstract/repository.dart';

class DeleteProductUseCase extends DeleteUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  DeleteProductUseCase({
    required super.repository,
    required FileRepository fileRepository,
  }) : _fileRepository = fileRepository;

  @override
  Future<Result<void>> call({required ProductEntity data}) async {
    // TODO: implement call

    final images = data.images
        .map((e) => ImageModel(id: data.id, url: e.path))
        .toList();
    final product = await super.call(data: data);

    if (product is Ok) return product;
    return await _fileRepository.deleteAll(images);
  }
}