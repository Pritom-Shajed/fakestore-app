part of 'performance_overlay_bloc.dart';

abstract class PerformanceOverlayEvent {}

class ChangePerformanceOverlay extends PerformanceOverlayEvent {
  final bool isEnable;
  
  ChangePerformanceOverlay(this.isEnable);
}
