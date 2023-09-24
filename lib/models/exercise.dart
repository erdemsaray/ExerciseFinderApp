import 'dart:convert';

List<Exercise> exerciseFromJson(String str) => List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
  Exercise({this.name, this.type, this.muscle, this.equipment, this.difficulty, this.instructions, this.program});

  final String? name;
  final String? type;
  final String? muscle;
  final String? equipment;
  final String? difficulty;
  final String? instructions;
  final String? program;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        type: json["type"],
        muscle: json["muscle"],
        equipment: json["equipment"],
        difficulty: json["difficulty"],
        instructions: json["instructions"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "muscle": muscle,
        "equipment": equipment,
        "difficulty": difficulty,
        "instructions": instructions,
      };
}
