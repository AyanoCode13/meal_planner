import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/utils/result.dart';

abstract class IUseCase<I, O> {
  Future<Result<O>> call({required I data});
}

abstract class _BaseUseCase<R, I, O> extends IUseCase<I, O> {
  final Repository<R> _repository;
  _BaseUseCase({required Repository<R> repository}) : _repository = repository;
}

class AddUseCase<T> extends _BaseUseCase<T, T, void> {
  AddUseCase({required super.repository});
  
  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
    return await super._repository.add(data);
  }
}

class GetAllUseCase<T> extends _BaseUseCase<T, void, List<T>> {
  GetAllUseCase({required super.repository});
  
  @override
  Future<Result<List<T>>> call({required void data}) async {
    // TODO: implement call
    return await super._repository.getAll();
  }
}

class GetByIdUseCase<T> extends _BaseUseCase<T, String, T?> {
  GetByIdUseCase({required super.repository});
  
  @override
  Future<Result<T?>> call({required String data}) async {
    // TODO: implement call
    return await super._repository.getById(data);
  }
}

class UpdateUseCase<T> extends _BaseUseCase<T, T, void> {
  UpdateUseCase({required super.repository});
  
  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
     return await super._repository.update(data);
  }
}

class DeleteUseCase<T> extends _BaseUseCase<T, T, void> {
  DeleteUseCase({required super.repository});
  
  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
     return await super._repository.delete(data);
  }
}
