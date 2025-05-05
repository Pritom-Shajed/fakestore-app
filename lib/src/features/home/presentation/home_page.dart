import 'package:auth/src/core/router/router.dart';
import 'package:auth/src/core/shared/error/app_error_view.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/core/utils/toasts/app_toasts.dart';
import 'package:auth/src/features/cart/presentation/bloc/cart_bloc.dart' as cartBloc;
import 'package:auth/src/features/cart/presentation/cart_page.dart';
import 'package:auth/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:auth/src/features/home/presentation/widgets/category_card.dart';
import 'package:auth/src/features/home/presentation/widgets/product_card.dart';
import 'package:auth/src/features/product_details/presentation/product_details.dart';
import 'package:auth/src/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icon_pack/solar_linear_icons.dart';

class HomePage extends StatefulWidget {
  static const name = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitialData();
    });
  }

  fetchInitialData() {
    context.read<HomeBloc>().add(FetchCategories());
    context.read<HomeBloc>().add(FetchProducts());
    context.read<cartBloc.CartBloc>().add(cartBloc.FetchCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goPushNamed(SettingsView.name);
        },
        child: const Icon(Icons.settings),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.goPushNamed(CartPage.name);
            },
            icon: Badge(
              label: BlocBuilder<cartBloc.CartBloc, cartBloc.CartState>(builder: (_, state) {
                if (state is cartBloc.CartItemsFetched) {
                  return Text(state.products.length.toString());
                }
                return const Text('0');
              }),
              child: const Icon(SolarLinearIcons.cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state is Error) {
            AppToasts.longToast(state.errorMessage);
          }
        }, builder: (context, state) {
          if (state is Loading) {
            return Center(child: AppLoaders.loaderWithText(context));
          } else if (state is HomeDataFetched) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                // Categories
                Text('Categories', style: context.text.titleMedium),
                SizedBox(
                  height: context.height * 0.15,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return CategoryCard(categoryName: state.categories[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: state.categories.length,
                  ),
                ),

                Text('Products', style: context.text.titleMedium),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      fetchInitialData();
                    },
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return ProductCard(
                          onTap: (id) => context.goPushNamed(ProductDetails.name, extra: id),
                          product: state.products[index],
                          onTapAddToCart: (product) =>
                              context.read<cartBloc.CartBloc>().add(cartBloc.AddToCart(product: product.toHive())),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: state.products.length,
                    ),
                  ),
                )
              ],
            );
          } else if (state is Error) {
            return AppErrorView(message: state.errorMessage);
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
