import 'package:meal_planner/data/database/repository/local.product.repository.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  LocalProductRepository, // the base repo injected via super.repository
  FileRepository,
])
void main(){

   
}