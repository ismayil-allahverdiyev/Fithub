import 'dart:convert';

import 'package:fithub/features/addRoutine/model/plan_model.dart';

DayModel dayModelFromJson(String str) => DayModel.fromJson(json.decode(str));

String dayModelToJson(DayModel data) => json.encode(data.toJson());

class DayModel {
  int id;
  DateTime date;
  int mood;
  int waterIntake;
  int sleepHours;
  List<PlanModel> planList;
  DateTime createdAt;

  DayModel({
    required this.id,
    required this.date,
    required this.mood,
    required this.waterIntake,
    required this.sleepHours,
    required this.planList,
    required this.createdAt,
  });

  factory DayModel.fromJson(Map<String, dynamic> data) => DayModel(
        id: data["id"],
        date: DateTime.fromMillisecondsSinceEpoch(
            int.parse(data["date"].toString().substring(0, 8)) * 100000),
        mood: data["mood"],
        waterIntake: data["waterIntake"],
        sleepHours: data["sleepHours"],
        planList: [
          for (int m = 0; m < json.decode(data["planList"]).length; m++)
            PlanModel.fromJson(json.decode(data["planList"])[m])
        ],
        createdAt: DateTime.parse(data["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "mood": mood,
        "waterIntake": waterIntake,
        "sleepHours": sleepHours,
        "planList": planList,
        "createdAt": createdAt,
      };
}
