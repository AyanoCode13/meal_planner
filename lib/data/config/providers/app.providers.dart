
import 'package:meal_planner/data/config/providers/local.providers.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> get appProviders async {
  final localProvidersList = await localProviders;
  return [...localProvidersList];
}