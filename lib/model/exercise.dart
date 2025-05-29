class Exercise {
  String? name;
  String? description;
  int? duration;
  String? difficulty;
  String? id;
  bool? isExerciseCompleted;

  Exercise({this.name, this.description, this.duration, this.difficulty, this.id,this.isExerciseCompleted});

  Exercise.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    difficulty = json['difficulty'];
    id = json['id'];
    isExerciseCompleted = json['isExerciseCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['duration'] = duration;
    data['difficulty'] = difficulty;
    data['id'] = id;
    data['isExerciseCompleted'] = isExerciseCompleted;
    return data;
  }
}
