import 'package:auth/src/core/shared/animations_widget/animated_popup.dart';
import 'package:auth/src/core/shared/animations_widget/animated_widget_shower.dart';
import 'package:auth/src/core/shared/list_tile/k_list_tile/k_list_tile.dart';
import 'package:auth/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/extensions/extensions.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/signout.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Signout',
          ),
        ),
      ),
      title: Text(
        t.signout,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SignoutPopup(),
      ),
    );
  }
}

class SignoutPopup extends StatelessWidget {
  const SignoutPopup({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.theme.dividerColor.withValues(alpha: 0.8)),
            ),
          ),
          TextButton(
            onPressed: () => context.read<AuthBloc>().add(Logout()),
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
