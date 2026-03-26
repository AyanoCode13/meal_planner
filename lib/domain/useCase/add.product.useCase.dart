import 'package:meal_planner/data/local/models/image.model.dart';
import 'package:meal_planner/data/local/repository/local/local.repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/utils/result.dart';

class AddProductUseCase extends AddUseCase<ProductEntity> {
  final FileRepository _fileRepository;
  AddProductUseCase({
    required super.repository,
    required FileRepository fileRepository,
  }) : _fileRepository = fileRepository;

  @override
  Future<Result<void>> call({required ProductEntity data}) async {
    // TODO: implement call
    final productResult = await super.call(data: data);

    switch (productResult) {
      case Error<void>():
        return productResult; // bail early, nothing to clean up

      case Ok<void>():
        final images = data.images
            .map(
              (e) => ImageModel(id: data.id, isThumbnail: false, url: e!.path),
            )
            .toList();

        final imagesResult = await _fileRepository.insertAll(images);

        // Step 2 — if images fail, roll back the product
        if (imagesResult is Error) {
          await super.repository.delete(data); // ← roll back
          return imagesResult;
        }

        return productResult;
    }
  }
}
