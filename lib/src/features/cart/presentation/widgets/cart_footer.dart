import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CartFooter extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  const CartFooter({super.key, required this.itemCount, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(bottom: 38, top: 12, right: 24, left: 24),
      decoration: BoxDecoration(
        color: context.theme.highlightColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Text.rich(
            TextSpan(
              text: 'Items: ',
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '$itemCount',
                  style: context.text.titleMedium?.copyWith(
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Price: ',
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '\$${totalPrice.toStringAsFixed(2)}',
                  style: context.text.titleMedium?.copyWith(
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
