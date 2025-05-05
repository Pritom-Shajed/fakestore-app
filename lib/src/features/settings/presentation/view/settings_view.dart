
import 'package:auth/main.dart';
import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/features/settings/presentation/view/components/locale_tile.dart';
import 'package:auth/src/features/settings/presentation/view/components/performance_overlay_tile.dart';
import 'package:auth/src/features/settings/presentation/view/components/signout_tile.dart';
import 'package:auth/src/features/settings/presentation/view/components/theme_tile.dart';
import 'package:auth/src/features/settings/presentation/view/components/url_config_tile.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverToBoxAdapter(
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    splashBorderRadius: borderRadius30,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    tabs: const [Tab(text: 'Basic'), Tab(text: 'Advanced')],
                  ),
                ),
              ],
              body: const TabBarView(children: [BasicPart(), AdvancePart()]),
            ),
          ),
        ),
      ),
    );
  }
}

class BasicPart extends StatelessWidget {
  const BasicPart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ThemeTile(),
          LocaleTile(),
          SignoutTile(),
        ],
      ),
    );
  }
}

class AdvancePart extends StatelessWidget {
  const AdvancePart({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PerformanceOverlayTile(),
          if (!isProduction) URLConfigTile(),
        ],
      ),
    );
  }
}
