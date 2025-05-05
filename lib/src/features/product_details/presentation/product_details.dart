import 'package:auth/src/core/shared/error/app_error_view.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/core/utils/toasts/app_toasts.dart';
import 'package:auth/src/features/product_details/presentation/bloc/product_details_bloc.dart';
import 'package:auth/src/features/product_details/presentation/widgets/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  static const name = 'product-details';
  final String productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitialData();
    });
  }

  fetchInitialData() {
    context.read<ProductDetailsBloc>().add(FetchProductDetails(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(listener: (_, state) {
        if (state is Error) {
          AppToasts.longToast(state.errorMessage);
        }
      }, builder: (_, state) {
        if (state is Loading) {
          return Center(child: AppLoaders.loaderWithText(context));
        } else if (state is ProductDetailsFetched) {
          return Column(
            spacing: 12,
            children: [
              // HEADER IMAGE
              if (state.product.image.isNotEmpty)
                Container(
                  width: double.maxFinite,
                  height: context.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(state.product.image), fit: BoxFit.cover),
                  ),
                ),

              // BODY
              ProductDetailsBody(
                product: state.product,
              )
            ],
          );
        } else {
          return const AppErrorView(message: 'Something went wrong!');
        }
      }),
    );
  }
}
