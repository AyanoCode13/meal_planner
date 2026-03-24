import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/local/dao/image.dao.dart';
import 'package:meal_planner/data/local/dao/product.dao.dart';
import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/data/local/repository/local/local.product.repository.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'product.repository_test.mocks.dart';

// ---------------------------------------------------------------------------
// Code-gen annotation — run:
//   dart run build_runner build --delete-conflicting-outputs
// ---------------------------------------------------------------------------

@GenerateMocks([ProductDAO, ImageDAO, FileStorageService, File])
void main() {
  late MockProductDAO productDAO;
  late MockImageDAO imageDAO;
  late MockFileStorageService fileStorageService;
  late LocalProductRepository sut;

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  ProductEntity makeEntity({
    required String id,
    required String name,
    List<File?>? images,
  }) => ProductEntity(
    id: id,
    name: name,
    images: images ?? [],
    description: '',
    price: 1.2,
    quantity: 3,
  
  );

  ProductModel makeModel({ required ProductEntity data}) =>
      ProductModel(
        id: data.id,
        name: data.name,
        description: data.description,
        price: data.price,
        quantity: data.quantity,
        // mirror your actual ProductModel fields
      );

  ImageModel makeImageModel({
    required String ownerId,
    required String url,
  }) => ImageModel(id: ownerId, url: url, isThumbnail: false);

  // -------------------------------------------------------------------------
  // Setup
  // -------------------------------------------------------------------------

  setUp(() {
    productDAO = MockProductDAO();
    imageDAO = MockImageDAO();
    fileStorageService = MockFileStorageService();

    sut = LocalProductRepository(
      productDAO: productDAO,
      imageDAO: imageDAO,
      fileStorageService: fileStorageService,
    );
  });

  // -------------------------------------------------------------------------
  // getAll
  // -------------------------------------------------------------------------

  group('getAll', () {
    test('returns mapped entities with loaded images on success', () async {
      final entity = makeEntity(id: Uuid().v4(), name: "Milk");
      final model = makeModel(data: entity);
      final mockFile = MockFile();
      final imageModel = makeImageModel(ownerId: entity.id, url: "product1.png");

      when(productDAO.findAll()).thenAnswer((_) async => [model]);
      when(
        imageDAO.findByOwner(entity.id),
      ).thenAnswer((_) async => [imageModel]);
      when(
        fileStorageService.getFile(folder: entity.id, fileName: imageModel.url),
      ).thenAnswer((_) async => mockFile);

      final result = await sut.getAll();

      expect(result, isA<Ok<List<ProductEntity>>>());
      final entities = (result as Ok<List<ProductEntity>>).value;
      expect(entities.length, 1);
      expect(entities.first.id, entity.id);
      expect(entities.first.images, [mockFile]);

      verify(productDAO.findAll()).called(1);
      verify(imageDAO.findByOwner(entity.id)).called(1);
    });

  //   test('returns empty list when DAO returns no rows', () async {
  //     when(productDAO.findAll()).thenAnswer((_) async => []);

  //     final result = await sut.getAll();

  //     expect(result, isA<Ok<List<ProductEntity>>>());
  //     expect((result as Ok).value, isEmpty);
  //   });

  //   test('returns Result.error when DAO throws', () async {
  //     when(productDAO.findAll()).thenThrow(Exception('db connection lost'));

  //     final result = await sut.getAll();

  //     expect(result, isA<Error<List<ProductEntity>>>());
  //   });

  //   test('maps multiple models correctly', () async {
  //     final models = [makeModel(), makeModel(name: 'Eggs')];

  //     when(productDAO.findAll()).thenAnswer((_) async => models);
  //     when(imageDAO.findByOwner(any)).thenAnswer((_) async => []);

  //     final result = await sut.getAll();

  //     final entities = (result as Ok<List<ProductEntity>>).value;
  //     expect(entities.map((e) => e.id), containsAll(['a', 'b']));
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // getById
  // // -------------------------------------------------------------------------

  // group('getById', () {
  //   test('returns entity with images when found', () async {
  //     final model = makeModel();
  //     final mockFile = MockFile();
  //     final imageModel = makeImageModel();

  //     when(productDAO.findById('prod-1')).thenAnswer((_) async => model);
  //     when(
  //       imageDAO.findByOwner('prod-1'),
  //     ).thenAnswer((_) async => [imageModel]);
  //     when(
  //       fileStorageService.getFile(folder: 'prod-1', fileName: 'thumbnail.jpg'),
  //     ).thenAnswer((_) async => mockFile);

  //     final result = await sut.getById('prod-1');

  //     expect(result, isA<Ok<ProductEntity?>>());
  //     expect((result as Ok<ProductEntity?>).value?.id, 'prod-1');
  //   });

  //   test('returns Ok(null) when product not found', () async {
  //     when(productDAO.findById(any)).thenAnswer((_) async => null);

  //     final result = await sut.getById('missing-id');

  //     expect(result, isA<Ok<ProductEntity?>>());
  //     expect((result as Ok<ProductEntity?>).value, isNull);
  //   });

  //   test('returns Result.error on DAO exception', () async {
  //     when(productDAO.findById(any)).thenThrow(Exception('query failed'));

  //     final result = await sut.getById('prod-1');

  //     expect(result, isA<Error<ProductEntity?>>());
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // add
  // // -------------------------------------------------------------------------

  // group('add', () {
  //   test('inserts model and saves images on success', () async {
  //     final mockFile = MockFile();
  //     final entity = makeEntity(images: [mockFile]);

  //     when(productDAO.insert(any)).thenAnswer((_) async {});
  //     when(
  //       fileStorageService.saveFile(file: mockFile, folder: 'prod-1'),
  //     ).thenAnswer((_) async => 'thumbnail.jpg');
  //     when(imageDAO.insertAll(any)).thenAnswer((_) async {});

  //     final result = await sut.add(entity);

  //     expect(result, isA<Ok<void>>());
  //     verify(productDAO.insert(any)).called(1);
  //     verify(
  //       fileStorageService.saveFile(file: mockFile, folder: 'prod-1'),
  //     ).called(1);
  //     verify(imageDAO.insertAll(any)).called(1);
  //   });

  //   test('still succeeds when entity has no images', () async {
  //     final entity = makeEntity(images: []);

  //     when(productDAO.insert(any)).thenAnswer((_) async {});
  //     when(imageDAO.insertAll(any)).thenAnswer((_) async {});

  //     final result = await sut.add(entity);

  //     expect(result, isA<Ok<void>>());
  //     verifyNever(
  //       fileStorageService.saveFile(
  //         file: anyNamed('file'),
  //         folder: anyNamed('folder'),
  //       ),
  //     );
  //   });

  //   test('returns Result.error when DAO insert throws', () async {
  //     final entity = makeEntity();

  //     when(productDAO.insert(any)).thenThrow(Exception('insert failed'));

  //     final result = await sut.add(entity);

  //     expect(result, isA<Error<void>>());
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // addAll
  // // -------------------------------------------------------------------------

  // group('addAll', () {
  //   test('inserts all entities', () async {
  //     final entities = [makeEntity(id: 'a'), makeEntity(id: 'b', name: 'Eggs')];

  //     when(productDAO.insert(any)).thenAnswer((_) async {});
  //     when(imageDAO.insertAll(any)).thenAnswer((_) async {});

  //     final result = await sut.addAll(entities);

  //     expect(result, isA<Ok<List<void>>>());
  //     verify(productDAO.insert(any)).called(2);
  //   });

  //   test('returns Result.error when any insert throws', () async {
  //     final entities = [makeEntity(id: 'a'), makeEntity(id: 'b')];

  //     when(productDAO.insert(any)).thenThrow(Exception('partial failure'));

  //     final result = await sut.addAll(entities);

  //     expect(result, isA<Error<List<void>>>());
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // update
  // // -------------------------------------------------------------------------

  // group('update', () {
  //   test('calls DAO update with mapped model', () async {
  //     final entity = makeEntity();

  //     when(productDAO.update(any)).thenAnswer((_) async {});

  //     final result = await sut.update(entity);

  //     expect(result, isA<Ok<void>>());
  //     verify(productDAO.update(any)).called(1);
  //   });

  //   test('returns Result.error on DAO exception', () async {
  //     final entity = makeEntity();

  //     when(productDAO.update(any)).thenThrow(Exception('update failed'));

  //     final result = await sut.update(entity);

  //     expect(result, isA<Error<void>>());
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // updateAll
  // // -------------------------------------------------------------------------

  // group('updateAll', () {
  //   test('updates each entity', () async {
  //     final entities = [makeEntity(id: 'a'), makeEntity(id: 'b')];

  //     when(productDAO.update(any)).thenAnswer((_) async {});

  //     final result = await sut.updateAll(entities);

  //     expect(result, isA<Ok<List<void>>>());
  //     verify(productDAO.update(any)).called(2);
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // delete
  // // -------------------------------------------------------------------------

  // group('delete', () {
  //   test('removes model, images row and files on success', () async {
  //     final entity = makeEntity();

  //     when(imageDAO.deleteFromOwner('prod-1')).thenAnswer((_) async {});
  //     when(
  //       fileStorageService.deleteFiles(folder: 'prod-1'),
  //     ).thenAnswer((_) async {});
  //     when(productDAO.remove(any)).thenAnswer((_) async {});

  //     final result = await sut.delete(entity);

  //     expect(result, isA<Ok<void>>());
  //     verify(imageDAO.deleteFromOwner('prod-1')).called(1);
  //     verify(fileStorageService.deleteFiles(folder: 'prod-1')).called(1);
  //     verify(productDAO.remove(any)).called(1);
  //   });

  //   test('returns Result.error when DAO remove throws', () async {
  //     final entity = makeEntity();

  //     when(imageDAO.deleteFromOwner(any)).thenAnswer((_) async {});
  //     when(
  //       fileStorageService.deleteFiles(folder: anyNamed('folder')),
  //     ).thenAnswer((_) async {});
  //     when(productDAO.remove(any)).thenThrow(Exception('delete failed'));

  //     final result = await sut.delete(entity);

  //     expect(result, isA<Error<void>>());
  //   });

  //   test('returns Result.error when file deletion throws', () async {
  //     final entity = makeEntity();

  //     when(imageDAO.deleteFromOwner(any)).thenAnswer((_) async {});
  //     when(
  //       fileStorageService.deleteFiles(folder: anyNamed('folder')),
  //     ).thenThrow(Exception('fs error'));

  //     final result = await sut.delete(entity);

  //     expect(result, isA<Error<void>>());
  //   });
  // });

  // // -------------------------------------------------------------------------
  // // deleteAll
  // // -------------------------------------------------------------------------

  // group('deleteAll', () {
  //   test('deletes each entity', () async {
  //     final entities = [makeEntity(id: 'a'), makeEntity(id: 'b')];

  //     when(imageDAO.deleteFromOwner(any)).thenAnswer((_) async {});
  //     when(
  //       fileStorageService.deleteFiles(folder: anyNamed('folder')),
  //     ).thenAnswer((_) async {});
  //     when(productDAO.remove(any)).thenAnswer((_) async {});

  //     final result = await sut.deleteAll(entities);

  //     expect(result, isA<Ok<List<void>>>());
  //     verify(productDAO.remove(any)).called(2);
  //   });
  });
}
