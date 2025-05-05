import 'package:auth/src/core/shared/error/app_error_view.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/core/utils/toasts/app_toasts.dart';
import 'package:auth/src/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:auth/src/features/cart/presentation/widgets/cart_footer.dart';
import 'package:auth/src/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  static const name = 'cart';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCart());
            },
            child: Text(
              'Clear',
              style: context.text.bodySmall?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (_, state) {
          if (state is Error) {
            AppToasts.longToast(state.errorMessage);
          }
        },
        builder: (_, state) {
          if (state is Loading) {
            return Center(child: AppLoaders.loaderWithText(context));
          } else if (state is CartItemsFetched) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No items in cart'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: state.products.length,
                    itemBuilder: (_, index) {
                      final product = state.products[index];
                      return ProductCard(
                        fromCartPage: true,
                        product: product.toModel(),
                        onTapRemoveFromCart: (value) {
                          context.read<CartBloc>().add(RemoveFromCart(product: product));
                        },
                      );
                    },
                  ),
                ),

                //  COUNT AND PRICE
                CartFooter(
                  itemCount: state.products.length,
                  totalPrice: state.products.map((e) => e.price).reduce((a, b) => a + b),
                ),
              ],
            );
          } else if (state is Error) {
            return AppErrorView(message: state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
