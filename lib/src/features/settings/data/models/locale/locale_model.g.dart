// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleProfileAdapter extends TypeAdapter<LocaleProfile> {
  @override
  final int typeId = 0;

  @override
  LocaleProfile read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocaleProfile.english;
      case 1:
        return LocaleProfile.bengali;
      default:
        return LocaleProfile.english;
    }
  }

  @override
  void write(BinaryWriter writer, LocaleProfile obj) {
    switch (obj) {
      case LocaleProfile.english:
        writer.writeByte(0);
      case LocaleProfile.bengali:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
