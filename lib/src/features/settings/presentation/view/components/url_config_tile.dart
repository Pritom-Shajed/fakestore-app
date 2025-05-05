import 'dart:math';

import 'package:auth/src/core/shared/animations_widget/animated_popup.dart';
import 'package:auth/src/core/shared/animations_widget/animated_widget_shower.dart';
import 'package:auth/src/core/shared/list_tile/k_list_tile/k_list_tile.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:auth/src/features/settings/presentation/bloc/url_config/bloc/url_config_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class URLConfigTile extends StatelessWidget {
  const URLConfigTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/url-config.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Url Config',
        ),
      ),
      title: Text(
        t.urlConfig,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const URLConfigPopup(),
      ),
    );
  }
}

class URLConfigPopup extends StatelessWidget {
  const URLConfigPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UrlConfigBloc, UrlConfigState>(
      builder: (context, state) {
        final bloc = context.read<UrlConfigBloc>();
        return AnimatedPopup(
          child: AlertDialog(
            scrollable: true,
            titlePadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            actionsPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
            title: const Text('URL Config'),
            content: SizedBox(
              width: min(280, context.width),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(25.0),
                    constraints:
                        const BoxConstraints(minWidth: 100.0, minHeight: 36.0),
                    isSelected: List.generate(
                      state.headers.length,
                      (i) => state.currUrlIndex == i,
                    ),
                    selectedColor: context.theme.primaryColor,
                    onPressed: (i) {
                      bloc.add(ToggleUrl(i));
                    },
                    children: List.generate(
                      state.headers.length,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          state.headers[i],
                          style: TextStyle(
                            color: state.currUrlIndex == i
                                ? context.theme.primaryColor
                                : context.theme.dividerColor.withValues(
                                    alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    enabled: false,
                    controller: state.baseUrlController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 10.0),
                      labelText: 'Base URL',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: context.theme.dividerColor.withValues(alpha: 0.8)),
                ),
              ),
              TextButton(
                child: Text(
                  'Done',
                  style: TextStyle(color: context.theme.primaryColor),
                ),
                onPressed: () async {
                  bloc.add(SubmitUrlConfig());
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}