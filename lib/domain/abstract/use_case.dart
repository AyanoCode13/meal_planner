import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/utils/result.dart';

abstract class IUseCase<I, O> {
  Future<Result<O>> call({required I data});
}

class BaseUseCase<R, I, O> implements IUseCase<I, O> {
  final Repository<R> _repository;

  BaseUseCase({required Repository<R> repository}) : _repository = repository;

  @override
  Future<Result<O>> call({required data}) {
    // TODO: implement call
    throw UnimplementedError();
  }


  Repository<R> get repository => _repository;
}

class AddUseCase<T> extends BaseUseCase<T, T, void> {
  AddUseCase({required super.repository});
}

class GetAllUseCase<T> extends BaseUseCase<T, void, List<T>> {
  GetAllUseCase({required super.repository});
}

class GetByIdUseCase<T> extends BaseUseCase<T, String, T?> {
  GetByIdUseCase({required super.repository});
}

class UpdateUseCase<T> extends BaseUseCase<T, T, void> {
  UpdateUseCase({required super.repository});
}

class DeleteUseCase<T> extends BaseUseCase<T, T, void> {
  DeleteUseCase({required super.repository});
}
