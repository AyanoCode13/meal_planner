import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/utils/result.dart';

final class AddProductUseCase
    implements UseCase<CreateProductDTO, ProductEntity> {
  final Repository<ProductEntity> _repository;

  AddProductUseCase({required Repository<ProductEntity> repository})
    : _repository = repository;
  @override
  Future<Result<ProductEntity>> call({required CreateProductDTO input}) async {
    try {
      final product = ProductEntity.create(dto: input);
      final res = await _repository.add(product);
      return Result.ok(product);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
