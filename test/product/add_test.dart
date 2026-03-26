import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/domain/useCase/product/add.product.useCase.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/mockito.dart';

import 'mocks/data.dart';
import 'mocks/mocks.mocks.dart';

void main() {
  late MockLocalProductRepository mockLocalProductRepository;
  late MockFileRepository mockFileRepository;
  late AddProductUseCase useCase;
  // Files

  setUpAll(() {
    registerCommonDummies();
  });

  setUp(() {
    setupMocks(
      assign: (repo, fileRepo) {
        mockLocalProductRepository = repo;
        mockFileRepository = fileRepo;
      },
    );

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
    test('always calls product repository before FileRepository', () async {
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
    });
  });
}
