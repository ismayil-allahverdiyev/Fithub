import 'dart:convert';

import 'package:flutter/material.dart';

DateModel dateModelFromJson(Map<String, dynamic> str) =>
    DateModel.fromJson(str);

String dateModelToJson(DateModel data) => json.encode(data.toJson());

class DateModel {
  DateTime date;
  bool isFull;

  DateModel({
    required this.date,
    required this.isFull,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        date: DateTime.fromMillisecondsSinceEpoch(
            int.parse(json["date"].toString().substring(0, 8)) * 100000),
        isFull: json["isFull"] == 0 ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "isFull": isFull ? 1 : 0,
      };
}
