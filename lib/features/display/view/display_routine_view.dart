import 'package:fithub/features/homepage/model/day_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/assets.dart';
import '../../addRoutine/view/widgets/calendar_widget.dart';
import '../../addRoutine/view/widgets/mood_selector.dart';
import '../../addRoutine/view/widgets/plan_list_widget.dart';
import '../../addRoutine/view/widgets/sleep_widget.dart';
import '../../addRoutine/view/widgets/water_intake_widget.dart';
import '../../homepage/view_model.dart/home_view_model.dart';

class DisplayRoutineView extends StatelessWidget {
  const DisplayRoutineView({
    super.key,
    required this.dayModel,
  });
  final DayModel dayModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            Assets.icon_arrow_left,
            scale: 2,
          ),
        ),
      ),
      body: ListView(
        children: [
          CalendarWidget(
            date: dayModel.date,
          ),
          MoodSelector(
            selectedMood: dayModel.mood,
          ),
          PlanListWidget(
            planList: dayModel.planList,
          ),
          WaterIntakeWidget(
            waterPercentage: dayModel.waterIntake,
          ),
          SleepWidget(
            sleepHours: dayModel.sleepHours.toDouble(),
          ),
        ],
      ),
    );
  }
}
