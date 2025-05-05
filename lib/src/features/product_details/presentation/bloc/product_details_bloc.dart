import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:auth/src/features/product_details/domain/usecase/fetch_product_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final FetchProductDetailsUsecase _fetchProductDetailsUsecase;
  ProductDetailsBloc(this._fetchProductDetailsUsecase) : super(Initial()) {
    on<FetchProductDetails>((event, emit) async {
      emit(Loading());
      try {
        final Either<String, ProductModel> result =
            await _fetchProductDetailsUsecase.call(productId: event.productId);
        result.fold(
          (error) {
            emit(Error(errorMessage: error));
            emit(Initial());
          },
          (data) {
            emit(ProductDetailsFetched(product: data));
          },
        );
      } catch (e) {
        emit(Error(errorMessage: e.toString()));
      }
    });
  }
}
