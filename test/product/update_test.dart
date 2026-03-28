import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/database/models/image.model.dart';
import 'package:meal_planner/domain/useCase/product/update.product.useCase.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/mockito.dart';

import 'mocks/data.dart';
import 'mocks/mocks.mocks.dart';

void main() {
  late MockLocalProductRepository mockProductRepository;
  late MockFileRepository mockFileRepository;
  late UpdateProductUseCase sut;

  setUp(() {
    setupMocks(
      assign: (repo, fileRepo) {
        mockProductRepository = repo;
        mockFileRepository = fileRepo;
      },
    );

    sut = UpdateProductUseCase(
      repository: mockProductRepository,
      fileRepository: mockFileRepository,
    );
  });

  setUpAll(() {
    // Ok
    registerCommonDummies();
  });

  group('when the parent UpdateUseCase succeeds', () {
    test('calls FileRepository.insertAll with the correct ImageModels '
        'and returns its Result', () async {
      // Arrange
      when(
        mockProductRepository.update(any),
      ).thenAnswer((_) async => Result.ok(null));

      when(
        mockFileRepository.insertAll(any),
      ).thenAnswer((_) async => Result.ok([]));

      // Act
      final result = await sut.call(data: product1);

      // Assert — parent repository was updated
      verify(mockProductRepository.update(product1)).called(1);

      // Assert — capture what insertAll actually received
      final captured = verify(
        mockFileRepository.insertAll(captureAny),
      ).captured;

      final passedImages = captured.first as List<ImageModel>;
      expect(passedImages, hasLength(images.length));
      expect(
        passedImages.map((e) => e.url),
        containsAllInOrder(images.map((e) => e.url)),
      );
      expect(passedImages.every((e) => e.id == product1.id), isTrue);

      expect(result, isA<Ok>());
    });

    test(
      'maps every image to an ImageModel using the product id as the model id',
      () async {
        when(
          mockProductRepository.update(product1),
        ).thenAnswer((_) async => Result.ok(null));

        // Capture the list passed to insertAll so we can assert on it.
        final capturedImages = <ImageModel>[];
        when(mockFileRepository.insertAll(captureAny)).thenAnswer((inv) async {
          capturedImages.addAll(
            inv.positionalArguments.first as List<ImageModel>,
          );
          return Result.ok([]);
        });

        await sut.call(data: product1);

        expect(capturedImages, hasLength(2));
        expect(capturedImages.every((img) => img.id == product1.id), isTrue);
      },
    );

    test(
      'propagates a failure from FileRepository back to the caller',
      () async {
        when(
          mockProductRepository.update(product1),
        ).thenAnswer((_) async => Result.ok(null));

        when(
          mockFileRepository.insertAll(any),
        ).thenAnswer((_) async => Result.error(Exception()));

        final result = await sut.call(data: product1);

        expect(result is Error, isTrue);
        verify(mockFileRepository.insertAll(any)).called(1);
      },
    );
  });
}
