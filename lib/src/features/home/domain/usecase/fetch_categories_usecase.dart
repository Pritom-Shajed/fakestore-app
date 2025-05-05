import 'package:auth/src/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class FetchCategoriesUsecase {
  const FetchCategoriesUsecase(this._repo);

  final HomeRepository _repo;

  Future<Either<String, List<dynamic>>> call() => _repo.fetchCategories();
}
