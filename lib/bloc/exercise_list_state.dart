
import '../model/exercise.dart';

abstract class ExerciseState {}

class LoadingState extends ExerciseState {}

class LoadedState extends ExerciseState {
  List<Exercise> exerciseList;
  LoadedState(this.exerciseList);
}

class ErrorState extends ExerciseState {
  final String message;
  ErrorState(this.message);
}
