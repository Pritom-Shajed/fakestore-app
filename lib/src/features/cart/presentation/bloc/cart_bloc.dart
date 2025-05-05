import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:auth/src/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:auth/src/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:auth/src/features/cart/domain/usecase/get_cart_items_usecase.dart';
import 'package:auth/src/features/cart/domain/usecase/remove_from_cart_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/logger/logger_helper.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUsecase _addToCartUsecase;
  final RemoveFromCartUsecase _removeFromCartUsecase;
  final ClearCartUsecase _clearCartUsecase;
  final GetCartItemsUsecase _getCartItemsUsecase;

  CartBloc(
    this._addToCartUsecase,
    this._removeFromCartUsecase,
    this._clearCartUsecase,
    this._getCartItemsUsecase,
  ) : super(CartInitial()) {
    on<FetchCartItems>((event, emit) async {
      emit(Loading());
      try {
        final result = await _getCartItemsUsecase.call();
        emit(CartItemsFetched(products: result));
      } catch (e) {
        log.e('Adding to cart error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });
    on<AddToCart>((event, emit) async {
      emit(Loading());
      try {
        await _addToCartUsecase.call(product: event.product);
        add(FetchCartItems());
      } catch (e) {
        log.e('Adding to cart error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });

    on<RemoveFromCart>((event, emit) async {
      emit(Loading());
      try {
        await _removeFromCartUsecase.call(product: event.product);
        add(FetchCartItems());
      } catch (e) {
        log.e('Removed from cart error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });

    on<ClearCart>((event, emit) async {
      emit(Loading());
      try {
        await _clearCartUsecase.call();
        add(FetchCartItems());
      } catch (e) {
        log.e('Cart clearing error: $e');
        emit(Error(errorMessage: e.toString()));
      }
    });
  }
}
