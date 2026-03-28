import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/database/models/image.model.dart';
import 'package:meal_planner/domain/useCase/product/delete.product.useCase.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/mockito.dart';

import 'mocks/data.dart';
import 'mocks/mocks.mocks.dart';

void main() {
  late MockLocalProductRepository mockLocalProductRepository;
  late MockFileRepository mockFileRepository;
  late DeleteProductUseCase sut;

  setUp(() {
    setupMocks(
      assign: (repo, fileRepo) {
        mockLocalProductRepository = repo;
        mockFileRepository = fileRepo;
      },
    );

    sut = DeleteProductUseCase(
      repository: mockLocalProductRepository,
      fileRepository: mockFileRepository,
    );
  });

  setUpAll(() {
    // Ok
    registerCommonDummies();
  });

  group('when the repository deletes the product successfully', () {
    test('returns Ok without touching the file repository', () async {
      when(
        mockLocalProductRepository.delete(product1),
      ).thenAnswer((_) async => Result.ok(null));

      final result = await sut.call(data: product1);

      expect(result, isA<Ok>());
      verifyNever(mockFileRepository.deleteAll(any));
    });

    test('returns Ok even when the product has no images', () async {
      when(
        mockLocalProductRepository.delete(product1),
      ).thenAnswer((_) async => Result.ok(null));

      final result = await sut.call(data: product1);

      expect(result, isA<Ok>());
      verifyNever(mockFileRepository.deleteAll(any));
    });
  });

  group('when the repository fails to delete the product', () {
    test(
      'calls fileRepository.deleteAll with correctly mapped ImageModels',
      () async {
        when(
          mockLocalProductRepository.delete(product1),
        ).thenAnswer((_) async => Result.error(Exception()));
        when(
          mockFileRepository.deleteAll(any),
        ).thenAnswer((_) async => Result.ok(null));

        await sut.call(data: product1);

        // Capture what was passed to deleteAll
        final captured = verify(
          mockFileRepository.deleteAll(captureAny),
        ).captured;
        final images = captured.single as List<ImageModel>;

        expect(images.length, 2);
        expect(images[0].id, product1.id);
        expect(images[0].url, product1.images[0].path);
        expect(images[1].id, product1.id);
        expect(images[1].url, product1.images[1].path);
      },
    );
    test('returns the result of fileRepository.deleteAll', () async {
      when(
        mockLocalProductRepository.delete(product1),
      ).thenAnswer((_) async => Result.error(Exception()));
      when(
        mockFileRepository.deleteAll(any),
      ).thenAnswer((_) async => Result.ok(null));

      final result = await sut.call(data: product1);

      expect(result, isA<Ok>());
    });

    test('propagates an Err from fileRepository.deleteAll', () async {
      when(
        mockLocalProductRepository.delete(product1),
      ).thenAnswer((_) async => Result.error(Exception()));
      when(
        mockFileRepository.deleteAll(any),
      ).thenAnswer((_) async => Result.error(Exception()));

      final result = await sut.call(data: product1);

      expect(result, isA<Error>());
    });

    test(
      'passes an empty list to deleteAll when product has no images',
      () async {
        when(
          mockLocalProductRepository.delete(product2),
        ).thenAnswer((_) async => Result.error(Exception()));
        when(
          mockFileRepository.deleteAll(any),
        ).thenAnswer((_) async => Result.ok(null));

        await sut.call(data: product2);

        final captured = verify(
          mockFileRepository.deleteAll(captureAny),
        ).captured;
        expect(captured.single as List<ImageModel>, isEmpty);
      },
    );
    group('ImageModel mapping', () {
      test('uses product.id (not image id) as ImageModel.id', () async {
        when(
          mockLocalProductRepository.delete(product1),
        ).thenAnswer((_) async => Result.error(Exception()));
        when(
          mockFileRepository.deleteAll(any),
        ).thenAnswer((_) async => Result.ok(null));

        await sut.call(data: product1);

        final captured = verify(
          mockFileRepository.deleteAll(captureAny),
        ).captured;
        final images = captured.single as List<ImageModel>;

        for (int i = 0; i < images.length; i++) {
          expect(images[i].id, product1.id);
          expect(images[i].url, product1.images[i].path);
        }

      });
    });
  });
}
