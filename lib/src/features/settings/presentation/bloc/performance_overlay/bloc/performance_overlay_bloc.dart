import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'performance_overlay_event.dart';
part 'performance_overlay_state.dart';

class PerformanceOverlayBloc
    extends Bloc<PerformanceOverlayEvent, PerformanceOverlayState> {
  final AppSettings settings;

  PerformanceOverlayBloc(this.settings)
      : super(PerformanceOverlayState(
            isEnabled: settings.performanceOverlayEnable)) {
    on<ChangePerformanceOverlay>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(ChangePerformanceOverlay event,
      Emitter<PerformanceOverlayState> emit) async {
    final updatedSettings =
        settings.copyWith(performanceOverlayEnable: event.isEnable);
    await updatedSettings.saveData();
    emit(state.copyWith(isEnabled: event.isEnable));
  }
}
