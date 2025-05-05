import 'package:auth/src/core/network/model/auth_store.dart';
import 'package:auth/src/features/cart/data/models/product_model_hive.dart';
import 'package:hive_ce/hive.dart';

import '../models/locale/locale_model.dart';
import '../models/settings_model.dart';
import '../models/theme/theme_model.dart';

class Boxes {
  static Box<LocaleProfile> localeProfile = Hive.box<LocaleProfile>(BoxNames.localeProfile);
  static Box<ThemeProfile> themeProfile = Hive.box<ThemeProfile>(BoxNames.themeProfile);
  static Box<AppSettings> appSettings = Hive.box<AppSettings>(BoxNames.appSettings);
  static Box<AuthStore> authStores = Hive.box<AuthStore>(BoxNames.authStores);
  static Box<ProductModelHive> productsCart = Hive.box<ProductModelHive>(BoxNames.productsCart);
}

class BoxNames {
  static const String localeProfile = 'localeProfile';
  static const String themeProfile = 'themeProfile';
  static const String appSettings = 'appSettings';
  static const String authStores = 'authStores';
  static const String productsCart = 'productsCart';
}

class HiveTypes {
  static const int localeProfile = 0;
  static const int themeProfile = 1;
  static const int appSettings = 2;
  static const int authStores = 3;
  static const int productsCart = 4;
}
