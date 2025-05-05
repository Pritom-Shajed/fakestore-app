import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/shared/animations_widget/animated_popup.dart';
import 'package:auth/src/core/shared/animations_widget/animated_widget_shower.dart';
import 'package:auth/src/core/shared/list_tile/k_list_tile/k_list_tile.dart';
import 'package:auth/src/features/settings/presentation/bloc/locale/locale_bloc.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/extensions/extensions.dart';
import '../../../data/models/locale/locale_model.dart';

class LocaleTile extends StatelessWidget {
  const LocaleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/language.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Language',
        ),
      ),
      title: Text(
        t.language,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: const Size(50, 48), backgroundColor: context.theme.highlightColor),
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LocaleChangerPopup(),
        ),
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: BlocBuilder<LocaleBloc, LocaleState>(
          builder: (_, state) {
            return Text(
              state.locale.label,
              style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
            );
          },
        ),
      ),
    );
  }
}

class LocaleChangerPopup extends StatelessWidget {
  const LocaleChangerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Language'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                LocaleProfile.values.length,
                (index) => BlocBuilder<LocaleBloc, LocaleState>(
                  builder: (_, state) => KListTile(
                    onTap: () async {
                      context.read<LocaleBloc>().add(
                            ChangeLocale(LocaleProfile.values[index]),
                          );
                      if (!context.mounted) return;
                      context.pop();
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    leading: Radio<LocaleProfile?>(
                      value: LocaleProfile.values[index],
                      groupValue: state.locale,
                      onChanged: (v) async {
                        context.read<LocaleBloc>().add(
                              ChangeLocale(v!),
                            );
                        if (!context.mounted) return;
                        context.pop();
                      },
                    ),
                    title: Text(LocaleProfile.values[index].label),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
