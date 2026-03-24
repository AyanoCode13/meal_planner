
import 'package:meal_planner/domain/abstract/view_model.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

final class RecipeViewModel extends BaseViewModel <RecipeEntity> {
  RecipeViewModel({required super.getAllUseCase, required super.getByIdUseCase, required super.addUseCase, required super.deleteUseCase, required super.updateUseCase});
}