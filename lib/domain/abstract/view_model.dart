import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/utils/command.dart';
import 'package:meal_planner/utils/result.dart';

abstract class ViewModel<T> {
  Future<Result<void>> _getAll();
  Future<Result<void>> _getById(String id);
  Future<Result<void>> _add(T data);
  Future<Result<void>> _update(T data);
  Future<Result<void>> _delete(T data);
}

class BaseViewModel<T> extends ChangeNotifier implements ViewModel<T> {
  final GetAllUseCase<T> _getAllUseCase;
  final GetByIdUseCase<T> _getByIdUseCase;
  final AddUseCase<T> _addUseCase;
  final DeleteUseCase<T> _deleteUseCase;
  final UpdateUseCase<T> _updateUseCase;

  BaseViewModel({
    required GetAllUseCase<T> getAllUseCase,
    required GetByIdUseCase<T> getByIdUseCase,
    required AddUseCase<T> addUseCase,
    required DeleteUseCase<T> deleteUseCase,
    required UpdateUseCase<T> updateUseCase,
  }) : _getAllUseCase = getAllUseCase,
       _getByIdUseCase = getByIdUseCase,
       _addUseCase = addUseCase,
       _deleteUseCase = deleteUseCase,
       _updateUseCase = updateUseCase {
    load = BasicCommand(_getAll)..execute();
    getById = ComplexCommand(_getById);
    add = ComplexCommand(_add);
    update = ComplexCommand(_update);
    delete = ComplexCommand(_delete);
  }

  late final BasicCommand load;
  late final ComplexCommand<void, T> add;
  late final ComplexCommand<void, T> update;
  late final ComplexCommand<void, T> delete;
  late final ComplexCommand<void, String> getById;
  List<Command> get commands => [load,add,update,delete];

  late List<T> _data;
  List<T> get data => _data;

  late T? _selected;
  T? get selected => _selected;

  final Logger _logger = Logger();

  @override
  Future<Result<void>> _getAll() async {
    // TODO: implement _getAll
    try {
      final res = await _getAllUseCase.call(data: null);
      switch (res) {
        case Ok<List<T>>():
          _data = res.value;
          return Result.ok(_logger.i("Fetched Data"));
        case Error<List<T>>():
          _logger.e(res.error);
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> _getById(String id) async {
    // TODO: implement _getById
     try {
      final res = await _getByIdUseCase.call(data: id);
      switch (res) {
        case Ok<T?>():
         
          return Result.ok( _logger.i("Fetched"));
        case Error<T?>():
          _logger.e(res.error);
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }



  @override
  Future<Result<void>> _add(T data) async {
    // TODO: implement _add
    try {
      final res = await _addUseCase.call(data: data);
      switch (res) {
        case Ok<void>():
          _logger.i("Done");
          return Result.ok(res.value);
        case Error<void>():
          _logger.e(res.error);
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> _update(T data) async {
    // TODO: implement _update
    try {
      final res = await _updateUseCase.call(data: data);
      switch (res) {
        case Ok<void>():
          _logger.i("Updated");
          return Result.ok(res.value);
        case Error<void>():
          _logger.e(res.error);
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }
  
  @override
  Future<Result<void>> _delete(T data) async{
    // TODO: implement _delete
    final res = await _deleteUseCase.call(data: data);
    try{
      switch (res) {
        case Ok<void>():
          _logger.i("Done");
          return Result.ok(res.value);
        case Error<void>():
          _logger.e(res.error);
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }
  
  


}
