import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:solar_icon_pack/solar_linear_icons.dart';

class CategoryCard extends StatelessWidget {
  final dynamic categoryName;
  const CategoryCard({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: borderRadius12,
          border: Border.all(
            color: context.theme.primaryColor,
            width: 0.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          const Icon(SolarLinearIcons.shop),
          Text(categoryName.toString()),
        ],
      ),
    );
  }
}
