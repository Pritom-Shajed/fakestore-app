import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/home/domain/usecase/fetch_categories_usecase.dart';
import 'package:auth/src/features/home/domain/usecase/fetch_products_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/logger/logger_helper.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCategoriesUsecase _fetchCategoriesUsecase;
  final FetchProductsUsecase _fetchProductsUsecase;

  HomeBloc(this._fetchCategoriesUsecase, this._fetchProductsUsecase) : super(HomeInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(Loading());
      try {
        final Either<String, List<dynamic>> result = await _fetchCategoriesUsecase.call();
        result.fold(
          (error) {
            log.e('Fetched categories error: $error');
            emit(Error(errorMessage: error));
            emit(HomeInitial());
          },
          (categoriesData) {
            log.i('Fetched categories: $categoriesData');

            // Retain existing products if available
            final List<ProductModel> existingProducts =
                state is HomeDataFetched ? (state as HomeDataFetched).products : [];

            emit(HomeDataFetched(categories: categoriesData, products: existingProducts));
          },
        );
      } catch (e) {
        log.e('Fetched categories error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });

    on<FetchProducts>((event, emit) async {
      emit(Loading());
      try {
        final Either<String, List<ProductModel>> result = await _fetchProductsUsecase.call();
        result.fold(
          (error) {
            log.e('Fetched products error: $error');
            emit(Error(errorMessage: error));
            emit(HomeInitial());
          },
          (productsData) {
            log.i('Fetched products: $productsData');

            // Retain existing categories if available
            final List<dynamic> existingCategories =
                state is HomeDataFetched ? (state as HomeDataFetched).categories : [];

            emit(HomeDataFetched(categories: existingCategories, products: productsData));
          },
        );
      } catch (e) {
        log.e('Fetched products error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });
  }
}
