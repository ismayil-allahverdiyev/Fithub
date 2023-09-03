import 'dart:convert';

import 'package:flutter/material.dart';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  String title;
  TimeOfDay timeOfDay;

  PlanModel({
    required this.title,
    required this.timeOfDay,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
      title: json["title"],
      timeOfDay: TimeOfDay(
        hour: int.parse(json["timeOfDay"].toString().split(" ")[0]),
        minute: int.parse(json["timeOfDay"].toString().split(" ")[1]),
      ));

  Map<String, dynamic> toJson() => {
        "title": title,
        "timeOfDay":
            timeOfDay.hour.toString() + " " + timeOfDay.minute.toString(),
      };
}
