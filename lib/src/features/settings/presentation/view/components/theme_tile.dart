import 'package:auth/src/core/shared/animations_widget/animated_widget_shower.dart';
import 'package:auth/src/core/shared/list_tile/k_list_tile/k_list_tile.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:auth/src/features/settings/presentation/bloc/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../data/models/theme/theme_model.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return KListTile(
          leading: AnimatedWidgetShower(
            size: 30.0,
            child: SvgPicture.asset(
              'assets/svgs/theme.svg',
              colorFilter: context.theme.primaryColor.toColorFilter,
              semanticsLabel: 'Theme',
            ),
          ),
          title: Text(
            t.theme,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: ToggleButtons(
            borderRadius: BorderRadius.circular(25.0),
            constraints: const BoxConstraints(minWidth: 48.0, minHeight: 36.0),
            isSelected: List.generate(
              ThemeProfile.values.length,
              (i) => ThemeProfile.values[i] == state.theme,
            ),
            selectedColor: context.theme.primaryColor,
            onPressed: (i) => context
                .read<ThemeBloc>()
                .add(ChangeTheme(ThemeProfile.values[i])),
            children: List.generate(
              ThemeProfile.values.length,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: SvgPicture.asset(
                  ThemeProfile.values[i].icon,
                  colorFilter: context.theme.primaryColor.toColorFilter,
                  semanticsLabel: ThemeProfile.values[i].label,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
