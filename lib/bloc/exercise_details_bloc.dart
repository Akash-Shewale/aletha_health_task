import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_details_event.dart';
import 'exercise_details_state.dart';

class ExerciseDetailsBloc extends Bloc<TimerEvent, ExerciseDetailsState> {
  Timer? _timer;
  int _currentTime = 0;

  ExerciseDetailsBloc() : super(StartTimerState(0)) {
    on<StartTimer>(_onStartTimer);
    on<Tick>(_onTick);
  }

  void _onStartTimer(StartTimer event, Emitter<ExerciseDetailsState> emit) {
    _timer?.cancel();
    _currentTime = event.duration;
    emit(StartTimerState(_currentTime));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(Tick(exerciseDetails: event.exerciseDetails));
    });
  }

  Future<void> _onTick(Tick event, Emitter<ExerciseDetailsState> emit) async {
    if (_currentTime > 0) {
      _currentTime--;
      emit(TimerRunning(_currentTime));
    } else {
      _timer?.cancel();
      //save data into the shared preference...
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString('Ids')!=null && prefs.getString("Ids")!.isNotEmpty)
        {
           List<String> exerciseCompletedIdsList = prefs.getString("Ids")!.split(",");
           exerciseCompletedIdsList.add(event.exerciseDetails.id.toString());
           String convertedCommaSeparatedString = exerciseCompletedIdsList.join(',');
           prefs.setString("Ids", convertedCommaSeparatedString);

        }else
          {
            prefs.setString("Ids", event.exerciseDetails.id.toString());
          }

      emit(TimerCompleted("Time Finished"));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
