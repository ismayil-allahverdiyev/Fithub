import 'package:fithub/core/utils/sql_helper.dart';
import 'package:fithub/features/addRoutine/model/plan_model.dart';
import 'package:flutter/material.dart';

class AddRoutineViewModel extends ChangeNotifier {
  int _selectedMood = 0;
  int get selectedMood => _selectedMood;
  set selectedMood(int value) {
    _selectedMood = value;
    notifyListeners();
  }

  int waterPercentage = 0;
  double amountOfSleep = 0;
  DateTime selectedDate = DateTime.now();

  TimeOfDay? selectedTime = const TimeOfDay(hour: 0, minute: 0);

  List<PlanModel> planList = [];

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
    SQLHelper.createItem(
      date: selectedDate.microsecondsSinceEpoch,
      mood: selectedMood,
      planList: [
        for (int i = 0; i < planList.length; i++) planModelToJson(planList[i])
      ].toString(),
      sleepHours: amountOfSleep.toInt(),
      waterIntake: waterPercentage,
    );
  }
}
