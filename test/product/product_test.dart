import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/data/local/repository/local/local.product.repository.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/domain/useCase/add.product.useCase.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_test.mocks.dart';

@GenerateMocks([
  LocalProductRepository, // the base repo injected via super.repository
  FileRepository,
])
void main() {
  late MockLocalProductRepository mockLocalProductRepository;
  late MockFileRepository mockFileRepository;
  late AddProductUseCase useCase;
  // Files
  final file1 = File("file1.png");
  final file2 = File("file2.png");
  final files = [file1, file2];

  // Products
  final product1 = ProductEntity.create(
    dto: CreateProductDTO(name: "Product 1", images: files),
  );
  final product2 = ProductEntity.create(
    dto: CreateProductDTO(name: "Product 2"),
  );

  setUpAll(() {
    // Ok
    provideDummy<Result<void>>(Result.ok(null));
    provideDummy<Result<List<String>>>(Result.ok([]));
    provideDummy<Result<List<ProductEntity>>>(Result.ok([]));
    // Error
    provideDummy<Result<void>>(Result.error(Exception()));
    provideDummy<Result<List<String>>>(Result.error(Exception()));
    provideDummy<Result<List<ProductEntity>>>(Result.error(Exception()));
  });

  setUp(() {
    mockLocalProductRepository = MockLocalProductRepository();
    mockFileRepository = MockFileRepository();

    useCase = AddProductUseCase(
      repository: mockLocalProductRepository,
      fileRepository: mockFileRepository,
    );
  });
  group('call() — success', () {
    test(
      'returns Success and delegates file insertion after saving the product',
      () async {
        when(
          mockLocalProductRepository.add(any),
        ).thenAnswer((_) async => Result.ok(null));

        // file insertion also succeeds
        when(
          mockFileRepository.insertAll(any),
        ).thenAnswer((_) async => Result.ok([]));

        final result = await useCase.call(data: product1);

        expect(result, isA<Ok>());

        verify(mockLocalProductRepository.add(product1)).called(1);

        // Verify images were mapped correctly and persisted
        final captured = verify(
          mockFileRepository.insertAll(captureAny),
        ).captured;
        final List<ImageModel> savedImages = captured.first as List<ImageModel>;

        expect(savedImages.length, equals(product1.images.length));
        expect(
          savedImages.map((img) => img.url),
          containsAllInOrder(product1.images.map((i) => i.path)),
        );
        expect(
          savedImages.map((img) => img.id),
          everyElement(equals(product1.id)),
        );
      },
    );

    test('works correctly when the product has no images', () async {
      when(
        mockLocalProductRepository.add(any),
      ).thenAnswer((_) async => Result.ok(null));

      // file insertion also succeeds
      when(
        mockFileRepository.insertAll(any),
      ).thenAnswer((_) async => Result.ok([]));

      final result = await useCase.call(data: product2);

      expect(result, isA<Ok>());

      // insertAll should still be called — with an empty list
      final captured = verify(
        mockFileRepository.insertAll(captureAny),
      ).captured;
      expect(captured.first, isEmpty);
    });
  });

  group('call() — product repository error', () {
    test('propagates the Error and never touches FileRepository', () async {
      final error = Result.error(Exception());
      when(mockLocalProductRepository.add(any)).thenAnswer((_) async => error);

      final result = await useCase.call(data: product2);

      // The exact same Error instance is forwarded

      // FileRepository must not be touched
      verifyNever(mockFileRepository.insertAll(any));

      // The exact same Error instance is forwarded
      expect(result, same(error));

      // FileRepository must not be touched
      verifyNever(mockFileRepository.insertAll(any));
    });

    test(
      'propagates an unexpected exception from the repository as an Error',
      () async {
        when(
          mockLocalProductRepository.add(any),
        ).thenThrow(Exception('Unexpected DB crash'));

        expect(
          () async => useCase.call(data: product1),
          throwsA(isA<Exception>()),
        );

        verifyNever(mockFileRepository.insertAll(any));
      },
    );
  });
  group('call() — FileRepository error', () {
    test(
      'returns FileRepository Error when product is saved but image insert fails',
      () async {
        final fileError = Result<List<String>>.error(Exception());

        when(
          mockLocalProductRepository.add(any),
        ).thenAnswer((_) async => Result.ok(null));
        when(
          mockFileRepository.insertAll(any),
        ).thenAnswer((_) async => fileError);

        final result = await useCase.call(data: product1);

        expect(result, same(fileError));

        // Both calls were still made
        verify(mockLocalProductRepository.add(product1)).called(1);
        verify(mockFileRepository.insertAll(any)).called(1);
      },
    );
  });
  group('image mapping', () {
    test(
      'maps every ProductImage to an ImageModel preserving id and path as url',
      () async {
        when(
          mockLocalProductRepository.add(any),
        ).thenAnswer((_) async => Result.ok(null));
        when(
          mockFileRepository.insertAll(any),
        ).thenAnswer((_) async => Result.ok([]));

        await useCase.call(data: product1);

        final captured = verify(
          mockFileRepository.insertAll(captureAny),
        ).captured;
        final List<ImageModel> models = captured.first as List<ImageModel>;

        expect(models[0].id, equals(product1.id));
        expect(models[0].url, equals(product1.images[0].path));
      },
    );
  });

  group('interaction ordering', () {
    test(
      'always calls product repository before FileRepository',
      () async {
        final order = <String>[];
       
        when(mockLocalProductRepository.add(any)).thenAnswer((_) async {
          order.add('product_repo');
          return Result.ok(null);
        });

        when(mockFileRepository.insertAll(any)).thenAnswer((_) async {
          order.add('file_repo');
          return Result.ok([]);
        });

        await useCase.call(data: product1);

        expect(order, equals(['product_repo', 'file_repo']));
      },
    );
  });
}
