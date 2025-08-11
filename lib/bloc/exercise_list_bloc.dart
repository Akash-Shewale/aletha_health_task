import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/exercise.dart';
import '../repository/api_repository.dart';
import 'exercise_list_event.dart';
import 'exercise_list_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ApiRepository repository;
  List<Exercise> exerciseList = <Exercise>[];
  ExerciseBloc(this.repository) : super(LoadingState()) {
    on<FetchExerciseEvent>((event, emit) async {
      exerciseList.clear();
      emit(LoadingState());
      //this is bloc example from main barnch
      // check this code..... changes are ready
      try {
        final response = await repository.fetchExercise();
        final List<dynamic> body = json.decode(response.body);
        exerciseList = body.map((item) => Exercise.fromJson(item)).toList();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? completedExerciseList = prefs.getString("Ids");
        if(completedExerciseList!=null)
          {
              List list = completedExerciseList.split(",");
              list = list.toSet().toList();
              for (var element in list) {
                Exercise? target = exerciseList.firstWhere(
                      (e) => e.id == element,
                );
                if(target!=null)
                  {
                    target.isExerciseCompleted = true;
                  }
              }
          }
        emit(LoadedState(exerciseList));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
