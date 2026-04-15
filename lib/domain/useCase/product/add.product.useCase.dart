import 'package:meal_planner/data/database/models/image.model.dart';
import 'package:meal_planner/data/database/repository/joins/local.category_and_product.repository.dart';
import 'package:meal_planner/data/database/repository/local.repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/utils/result.dart';

class AddProductUseCase extends AddUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  final CategoriesAndProductsRepository _categoriesAndProductsRepository;

  AddProductUseCase({required super.repository, required FileRepository fileRepository, required CategoriesAndProductsRepository categoriesAndProductsRepository}) : _fileRepository = fileRepository, _categoriesAndProductsRepository = categoriesAndProductsRepository;

  

  @override
  Future<Result<void>> call({required ProductEntity data}) async {
  

    final images = data.images
        .map((e) => ImageModel(id: data.id, url: e.path))
        .toList();
    final product = await super.call(data: data);

    if (product is Error) return product;
    return await _fileRepository.insertAll(images);
  }
}
