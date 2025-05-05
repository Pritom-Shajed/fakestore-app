part of '../extensions.dart';

extension FileExt on File {
  Future<String> get base64 async => base64Encode(await readAsBytes());

  String get name => path.split('/').last;

  Future<File> saveToAppDir() async =>
      await copy(join(sl<AppDir>().files.path, name));
}
