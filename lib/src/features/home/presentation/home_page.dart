import 'package:auth/src/core/router/router.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/loader/app_loaders.dart';
import 'package:auth/src/core/utils/toasts/app_toasts.dart';
import 'package:auth/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:auth/src/features/home/presentation/widgets/category_card.dart';
import 'package:auth/src/features/home/presentation/widgets/product_card.dart';
import 'package:auth/src/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const name = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    context.read<HomeBloc>().add(FetchCategories());
    context.read<HomeBloc>().add(FetchProducts());
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
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, index) {
                      return ProductCard(product: state.products[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: state.products.length,
                  ),
                )
              ],
            );
          } else if (state is Error) {
            return Text(state.errorMessage);
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
