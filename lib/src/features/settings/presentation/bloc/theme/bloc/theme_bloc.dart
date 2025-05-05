import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:auth/src/features/settings/data/models/theme/theme_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppSettings settings;

  ThemeBloc(this.settings) : super(ThemeState(theme: settings.theme)) {
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onChangeTheme(
      ChangeTheme event, Emitter<ThemeState> emit) async {
    final updatedSettings = settings.copyWith(theme: event.theme);
    await updatedSettings.saveData();
    emit(state.copyWith(theme: event.theme));
  }
}
