import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/data/local/repository/local/local.repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/utils/result.dart';

class AddProductUseCase extends AddUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  AddProductUseCase({
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
