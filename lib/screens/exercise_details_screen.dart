import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_check/model/exercise.dart';
import '../bloc/exercise_details_bloc.dart';
import '../bloc/exercise_details_event.dart';
import '../bloc/exercise_details_state.dart';
import '../widgets/rich_text.dart';
import 'home_page.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final Exercise exerciseDetails;

  const ExerciseDetailsScreen({super.key, required this.exerciseDetails});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Details"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            final duration = widget.exerciseDetails.duration ?? 0;
            //context.read<ExerciseDetailsBloc>().add(Tick(exerciseDetails: widget.exerciseDetails));
            context.read<ExerciseDetailsBloc>().add(StartTimer(duration,widget.exerciseDetails));
          },
          child: const Text('Start Exercise'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Exercise Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      RichTextCards(title: "Exercise Name : ", subTitle: widget.exerciseDetails.name ?? ''),
                      const SizedBox(height: 5),
                      RichTextCards(title: "Description : ", subTitle: widget.exerciseDetails.description ?? ''),
                      const SizedBox(height: 5),
                      RichTextCards(title: "Duration : ", subTitle: "${widget.exerciseDetails.duration ?? ''} seconds"),
                      const SizedBox(height: 5),
                      RichTextCards(title: "Difficulty : ", subTitle: widget.exerciseDetails.difficulty ?? ''),
                      const SizedBox(height: 10),
                      BlocConsumer<ExerciseDetailsBloc, ExerciseDetailsState>(
                        builder: (context, state) {
                          if (state is TimerRunning || state is StartTimerState) {
                            final time = state is TimerRunning ? state.time : widget.exerciseDetails.duration ?? 0;
                            return Center(
                              child: Text(
                                "Time Left: $time s",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            );
                          } else if (state is TimerCompleted) {}
                          return const SizedBox.shrink();
                        },
                        listener: (context, state) {
                          if (state is TimerCompleted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Time's up!\nExercise is completed."),
                                backgroundColor: Colors.blue,
                              ),
                            );

                            //navigate to home screen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const MyHomePage()),
                                  (Route<dynamic> route) => false, // remove all previous routes
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
