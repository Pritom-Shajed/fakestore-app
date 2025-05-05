import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';

enum CartAddOrRemoveBtnType {
  add,
  remove,
}

class CartAddOrRemoveBtn extends StatelessWidget {
  final CartAddOrRemoveBtnType type;
  final VoidCallback? onTap;
  const CartAddOrRemoveBtn({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: Container(
        alignment: Alignment.center,
        height: context.height * 0.025,
        width: context.height * 0.025,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(type == CartAddOrRemoveBtnType.add ? '+' : '-',
            style: context.text.bodyMedium?.copyWith(color: white)),
      ),
    );
  }
}
