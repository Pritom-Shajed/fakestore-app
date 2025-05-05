import 'package:auth/src/features/settings/data/models/locale/locale_model.dart';
import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final AppSettings settings;

  LocaleBloc(this.settings) : super(LocaleState(locale: settings.locale)) {
    on<ChangeLocale>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(
      ChangeLocale event, Emitter<LocaleState> emit) async {
    final updatedSettings = settings.copyWith(locale: event.locale);
    await updatedSettings.saveData();
    emit(state.copyWith(locale: event.locale));
  }
}
