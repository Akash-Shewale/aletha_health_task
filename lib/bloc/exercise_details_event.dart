import '../model/exercise.dart';

abstract class TimerEvent {}

class StartTimer extends TimerEvent {
  final int duration;
  final Exercise exerciseDetails;
  StartTimer(this.duration,this.exerciseDetails);
}

class Tick extends TimerEvent {
  final Exercise exerciseDetails;
  Tick({required this.exerciseDetails});
}