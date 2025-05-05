part of 'performance_overlay_bloc.dart';

class PerformanceOverlayState {
  final bool isEnabled;

  PerformanceOverlayState({required this.isEnabled});

  PerformanceOverlayState copyWith({bool? isEnabled}) {
    return PerformanceOverlayState(isEnabled: isEnabled ?? this.isEnabled);
  }
}
