import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AnimatedWidgetShower extends StatelessWidget {
  const AnimatedWidgetShower({
    super.key,
    required this.child,
    required this.size,
    this.padding = 6.0,
    this.color,
  });

  final Widget child;
  final double size;
  final double padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: roundedRectangleBorder15,
      color: color ?? context.theme.primaryColor.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          height: size,
          width: size,
          child: TweenAnimationBuilder(
            curve: Curves.easeOut,
            duration: kAnimationDuration(0.4),
            tween: Tween<double>(begin: 0, end: size),
            builder: (_, double x, __) {
              return Center(
                child: SizedBox(
                  height: x,
                  width: x,
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
