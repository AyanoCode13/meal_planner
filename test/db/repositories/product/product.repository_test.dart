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
  late MockFile mockFile;

  //Entities
  late ProductEntity entity1;
  late ProductEntity entity2;

  //Models
  late ProductModel model1;
  late ProductModel model2;

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  ProductEntity makeEntity({
    required String name,
    List<File?>? images,
  }) => ProductEntity(
    id: Uuid().v4(),
    name: name,
    images: images ?? [],
    description: '',
    price: 1.2,
    quantity: 3,
  );

  ProductModel makeModel({required ProductEntity data}) => ProductModel(
    id: data.id,
    name: data.name,
    description: data.description,
    price: data.price,
    quantity: data.quantity,
    // mirror your actual ProductModel fields
  );

  ImageModel makeImageModel({required String ownerId, required String url}) =>
      ImageModel(id: ownerId, url: url, isThumbnail: false);

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

  setUpAll(() {
    mockFile = MockFile();
    entity1 = makeEntity(
      name: "Milk",
      images: [File("product1.png"), File("thumbnail1.jpg")],
    );
    entity2 = makeEntity(
      name: "Eggs",
      images: [File("product2.png"), File("thumbnail2.jpg")],
    );
    model1 = makeModel(data: entity1);
    model2 = makeModel(data: entity2);
  });

  // -------------------------------------------------------------------------
  // getAll
  // -------------------------------------------------------------------------

  group('getAll', () {
    test('returns mapped entities with loaded images on success', () async {
     
      final imageModel = makeImageModel(
        ownerId: entity1.id,
        url: "product1.png",
      );

      when(productDAO.findAll()).thenAnswer((_) async => [model1]);
      when(
        imageDAO.findByOwner(entity1.id),
      ).thenAnswer((_) async => [imageModel]);
      when(
        fileStorageService.getFile(
          folder: entity1.id,
          fileName: imageModel.url,
        ),
      ).thenAnswer((_) async => mockFile);

      final result = await sut.getAll();

      expect(result, isA<Ok<List<ProductEntity>>>());
      final entities = (result as Ok<List<ProductEntity>>).value;
      expect(entities.length, 1);
      expect(entities.first.id, entity1.id);
      expect(entities.first.images, [mockFile]);

      verify(productDAO.findAll()).called(1);
      verify(imageDAO.findByOwner(entity1.id)).called(1);
    });

    test('returns empty list when DAO returns no rows', () async {
      when(productDAO.findAll()).thenAnswer((_) async => []);

      final result = await sut.getAll();

      expect(result, isA<Ok<List<ProductEntity>>>());
      expect((result as Ok).value, isEmpty);
    });

    test('returns Result.error when DAO throws', () async {
      when(productDAO.findAll()).thenThrow(Exception('db connection lost'));

      final result = await sut.getAll();

      expect(result, isA<Error<List<ProductEntity>>>());
    });

    test('maps multiple models correctly', () async {
      final models = [model1, model2];

      when(productDAO.findAll()).thenAnswer((_) async => models);
      when(imageDAO.findByOwner(any)).thenAnswer((_) async => []);

      final result = await sut.getAll();

      final entities = (result as Ok<List<ProductEntity>>).value;
      expect(entities.map((e) => e.id), containsAll([entity1.id, entity2.id]));
    });
  });

  // // -------------------------------------------------------------------------
  // // getById
  // // -------------------------------------------------------------------------

  group('getById', () {
    test('returns entity with images when found', () async {
      final imageModel = makeImageModel(
        ownerId: entity1.id,
        url: 'thumbnail.jpg',
      );

      when(productDAO.findById(entity1.id)).thenAnswer((_) async => model1);
      when(
        imageDAO.findByOwner(entity1.id),
      ).thenAnswer((_) async => [imageModel]);
      when(
        fileStorageService.getFile(
          folder: entity1.id,
          fileName: 'thumbnail.jpg',
        ),
      ).thenAnswer((_) async => mockFile);

      final result = await sut.getById(entity1.id);

      expect(result, isA<Ok<ProductEntity?>>());
      expect((result as Ok<ProductEntity?>).value?.id, entity1.id);
    });

    test('returns Ok(null) when product not found', () async {
      when(productDAO.findById(any)).thenAnswer((_) async => null);

      final result = await sut.getById(entity1.id);

      expect(result, isA<Ok<ProductEntity?>>());
      expect((result as Ok<ProductEntity?>).value, isNull);
    });

    test('returns Result.error on DAO exception', () async {
      when(productDAO.findById(any)).thenThrow(Exception('query failed'));

      final result = await sut.getById(entity1.id);

      expect(result, isA<Error<ProductEntity?>>());
    });
  });

  // // -------------------------------------------------------------------------
  // // add
  // // -------------------------------------------------------------------------

  group('add', () {
    test('inserts model and saves images on success', () async {
      final mockFile = MockFile();
      final entity = makeEntity(name: "entity3", images: [mockFile]);

      when(productDAO.insert(any)).thenAnswer((_) async {});
      when(
        fileStorageService.saveFile(file: mockFile, folder: entity.id),
      ).thenAnswer((_) async => 'thumbnail.jpg');
      when(imageDAO.insertAll(any)).thenAnswer((_) async {});

      final result = await sut.add(entity);

      expect(result, isA<Ok<void>>());
      verify(productDAO.insert(any)).called(1);
      verify(
        fileStorageService.saveFile(file: mockFile, folder: entity.id),
      ).called(1);
      verify(imageDAO.insertAll(any)).called(1);
    });

    test('still succeeds when entity has no images', () async {
      final entity = makeEntity(name: "Entity", images: []);

      when(productDAO.insert(any)).thenAnswer((_) async {});
      when(imageDAO.insertAll(any)).thenAnswer((_) async {});

      final result = await sut.add(entity);

      expect(result, isA<Ok<void>>());
      verifyNever(
        fileStorageService.saveFile(
          file: anyNamed('file'),
          folder: anyNamed('folder'),
        ),
      );
    });

    test('returns Result.error when DAO insert throws', () async {
      final entity = makeEntity(name: "Entity", images: []);

      when(productDAO.insert(any)).thenThrow(Exception('insert failed'));

      final result = await sut.add(entity);

      expect(result, isA<Error<void>>());
    });
  });

 
  // -------------------------------------------------------------------------
  // update
  // -------------------------------------------------------------------------

  group('update', () {
    test('calls DAO update with mapped model', () async {
     

      when(productDAO.update(any)).thenAnswer((_) async {});

      final result = await sut.update(entity1.copyWith(price: 2.5));

      expect(result, isA<Ok<void>>());
      verify(productDAO.update(any)).called(1);
    });

    test('returns Result.error on DAO exception', () async {
      
      when(productDAO.update(any)).thenThrow(Exception('update failed'));

      final result = await sut.update(entity2.copyWith(name: "Updated"));

      expect(result, isA<Error<void>>());
    });
  });


  // -------------------------------------------------------------------------
  // delete
  // -------------------------------------------------------------------------

  group('delete', () {
    test('removes model, images row and files on success', () async {
      

      when(imageDAO.deleteFromOwner(entity1.id)).thenAnswer((_) async {});
      when(
        fileStorageService.deleteFiles(folder: entity1.id),
      ).thenAnswer((_) async {});
      when(productDAO.remove(any)).thenAnswer((_) async {});

      final result = await sut.delete(entity1);

      expect(result, isA<Ok<void>>());
      verify(imageDAO.deleteFromOwner(entity1.id)).called(1);
      verify(fileStorageService.deleteFiles(folder: entity1.id)).called(1);
      verify(productDAO.remove(any)).called(1);
    });

    test('returns Result.error when DAO remove throws', () async {
    

      when(imageDAO.deleteFromOwner(any)).thenAnswer((_) async {});
      when(
        fileStorageService.deleteFiles(folder: entity1.id),
      ).thenAnswer((_) async {});
      when(productDAO.remove(any)).thenThrow(Exception('delete failed'));

      final result = await sut.delete(entity2);

      expect(result, isA<Error<void>>());
    });

    test('returns Result.error when file deletion throws', () async {
     

      when(imageDAO.deleteFromOwner(any)).thenAnswer((_) async {});
      when(
        fileStorageService.deleteFiles(folder: entity2.id),
      ).thenThrow(Exception('fs error'));

      final result = await sut.delete(entity2);

      expect(result, isA<Error<void>>());
    });
  });
}
