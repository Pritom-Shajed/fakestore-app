import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:solar_icon_pack/solar_icon_pack.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 12,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: context.text.titleMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.theme.primaryColor,
                    width: 0.2,
                  ),
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    const Icon(
                      SolarLinearIcons.tagPrice,
                      size: 16,
                    ),
                    Text(
                      '${product.price}\$',
                      style: context.text.bodySmall,
                    )
                  ],
                ),
              )
            ],
          ),
          Text(
            product.description,
            style: context.text.bodySmall,
          ),
        ],
      ),
    );
  }
}
