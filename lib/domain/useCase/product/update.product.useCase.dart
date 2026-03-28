
import '../../../data/database/models/image.model.dart';
import '../../../utils/result.dart';
import '../../abstract/repository.dart';
import '../../abstract/use_case.dart';
import '../../entities/product/product.entity.dart';

class UpdateProductUseCase extends UpdateUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  UpdateProductUseCase({
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

    if (product is Error) return product;
    return await _fileRepository.insertAll(images);
  }
}