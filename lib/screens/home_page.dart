import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_check/widgets/rich_text.dart';
import '../bloc/exercise_list_bloc.dart';
import '../bloc/exercise_list_event.dart';
import '../bloc/exercise_list_state.dart';
import 'exercise_details_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event here
    context.read<ExerciseBloc>().add(FetchExerciseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise List"),
      ),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            if (state.exerciseList.isEmpty) {
              return const Center(child: Text("Data Not Available"));
            } else {
              return ListView.builder(
                itemCount: state.exerciseList.length,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  bool? isCompleted = state.exerciseList[position].isExerciseCompleted;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailsScreen(exerciseDetails: state.exerciseList[position]),
                        ),
                      );
                    },
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
                            RichTextCards(title: "Exercise Name : ", subTitle: state.exerciseList[position].name ?? ''),
                            const SizedBox(
                              height: 5,
                            ),
                            RichTextCards(title: "Duration : ", subTitle: state.exerciseList[position].duration == null ? '' : state.exerciseList[position].duration!.toString()),
                            const SizedBox(
                              height: 5,
                            ),
                            if (isCompleted != null && isCompleted)
                              Row(
                                children: [
                                  const Text("Completed"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.check, color: Colors.green),
                                    onPressed: () {},
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is ErrorState) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
