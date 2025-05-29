import '../model/exercise.dart';

abstract class ExerciseDetailsState {}

class StartTimerState extends ExerciseDetailsState {
  final int time;
  StartTimerState(this.time);
}

class TimerRunning extends ExerciseDetailsState {
  final int time;
  TimerRunning(this.time);
}

class TimerCompleted extends ExerciseDetailsState {
  final String message;
  TimerCompleted(this.message);
}