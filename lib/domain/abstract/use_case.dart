import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/utils/result.dart';

abstract class UseCase<I, O> {
  Future<Result<O>> call({required I data });
}
class GetAllUseCase<T> implements UseCase<void, List<T>> {
  final Repository<T> _repository;

  GetAllUseCase({required Repository<T> repository}) : _repository = repository;
  
  @override
  Future<Result<List<T>>> call({required void data}) {
    // TODO: implement call
    return _repository.getAll();
  }
}

class GetByIdUseCase<T> implements UseCase<String, T?> {
  final Repository<T> _repository;

  GetByIdUseCase({required Repository<T> repository}) : _repository = repository;
  
  @override
  Future<Result<T?>> call({required String data}) async {
    // TODO: implement call
    return await _repository.getById(data);
  }
  
  
}

class AddUseCase<T> implements UseCase<T,void> {
  final Repository<T> _repository;

  AddUseCase({required Repository<T> repository}) : _repository = repository;

  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
    return await _repository.add(data);
  }
}


class UpdateUseCase<T> implements UseCase<T,void> {
  final Repository<T> _repository;

  UpdateUseCase({required Repository<T> repository}) : _repository = repository;

  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
    return await _repository.update(data);
  }
}

class DeleteUseCase<T> implements UseCase<T,void> {
  final Repository<T> _repository;

  DeleteUseCase({required Repository<T> repository}) : _repository = repository;

  @override
  Future<Result<void>> call({required T data}) async {
    // TODO: implement call
    return await _repository.delete(data);
  }
}

