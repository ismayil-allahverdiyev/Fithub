import 'package:fithub/core/utils/sql_helper.dart';
import 'package:fithub/features/addRoutine/model/date_model.dart';
import 'package:fithub/features/addRoutine/model/plan_model.dart';
import 'package:flutter/material.dart';

class AddRoutineViewModel extends ChangeNotifier {
  AddRoutineViewModel() {
    getCalendarDate();
  }

  // Mood selector
  int _selectedMood = 0;
  int get selectedMood => _selectedMood;
  set selectedMood(int value) {
    _selectedMood = value;
    notifyListeners();
  }

  // Water selector
  int waterPercentage = 0;

  // Sleep selector
  double amountOfSleep = 0;

  // Date selector
  DateTime selectedDate = DateTime.now();

  TimeOfDay? selectedTime = const TimeOfDay(hour: 0, minute: 0);

  List<PlanModel> planList = [];

  List<DateTime> dateList = [];

  TextEditingController planController = TextEditingController();

  selectTime({required BuildContext context}) async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    selectedTime ??= const TimeOfDay(hour: 0, minute: 0);
    notifyListeners();
  }

  saveToTheList() {
    planList.add(
      PlanModel(
        title: planController.text,
        timeOfDay: selectedTime!,
      ),
    );
    planController.clear();
    selectedTime = const TimeOfDay(hour: 0, minute: 0);
    notifyListeners();
  }

  editTheList({required int index}) {
    planList[index].timeOfDay = selectedTime!;
    planList[index].title = planController.text;
    planController.clear();
    selectedTime = const TimeOfDay(hour: 0, minute: 0);
    notifyListeners();
  }

  deleteFromTheList({required int index}) {
    planList.removeAt(index);
    notifyListeners();
  }

  prepareTheBottomSheet({required int index}) {
    if (index == -1) {
      planController.clear();
      selectedTime = const TimeOfDay(hour: 0, minute: 0);
    } else {
      planController.text = planList[index].title;
      selectedTime = planList[index].timeOfDay;
    }
  }

  changeWaterIntake({required bool isAdd}) {
    if (isAdd) {
      if (waterPercentage <= 90) waterPercentage += 10;
    } else {
      if (waterPercentage >= 10) waterPercentage -= 10;
    }
    notifyListeners();
  }

  changeAmountOfSleep({required double amount}) {
    amountOfSleep = amount;
    notifyListeners();
  }

  addRoutine() async {
    await SQLHelper.createItemInPlans(
      date: selectedDate.microsecondsSinceEpoch,
      mood: selectedMood,
      planList: [
        for (int i = 0; i < planList.length; i++) planModelToJson(planList[i])
      ].toString(),
      sleepHours: amountOfSleep.toInt(),
      waterIntake: waterPercentage,
    );
  }

  getCalendarDate() async {
    var response = await SQLHelper.getItems("dates");
    if (response != null) {
      dateList = [];
      response.forEach((element) {
        DateModel dateInfo = dateModelFromJson(element);
        if (dateInfo.isFull == true) {
          dateList.add(dateInfo.date);
        }
      });
      notifyListeners();
    }
  }

  void setDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }
}
