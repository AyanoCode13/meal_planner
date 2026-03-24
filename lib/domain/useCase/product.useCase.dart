import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
class GetAllProductsUseCase extends GetAllUseCase<ProductEntity> {
  GetAllProductsUseCase({required super.repository});
}

class GetProductByIdUseCase extends GetByIdUseCase<ProductEntity> {
  GetProductByIdUseCase({required super.repository});
}


class AddProductUseCase extends AddUseCase<ProductEntity>{
  AddProductUseCase({required super.repository});
}

class UpdateProductUseCase extends UpdateUseCase<ProductEntity>{
  UpdateProductUseCase({required super.repository});
}


class DeleteProductUseCase extends DeleteUseCase<ProductEntity> {
  DeleteProductUseCase({required super.repository});
}