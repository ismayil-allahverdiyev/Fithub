import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/core/theme/assets.dart';
import 'package:fithub/features/addRoutine/view/widgets/plan_list_widget.dart';
import 'package:fithub/features/addRoutine/view/widgets/sleep_widget.dart';
import 'package:fithub/features/addRoutine/view/widgets/water_intake_widget.dart';
import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:fithub/features/homepage/view_model.dart/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/mood_selector.dart';

class AddRoutine extends StatelessWidget {
  const AddRoutine({super.key});

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
          const CalendarWidget(),
          const MoodSelector(),
          const PlanListWidget(),
          const WaterIntakeWidget(),
          const SleepWidget(),
          Consumer<HomeViewModel>(
            builder: (context, viewModel, _) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<AddRoutineViewModel>(context, listen: false)
                      .addRoutine()
                      .then((value) {
                    viewModel.updateListOfDays();
                  });
                },
                child: const Text("Add"),
              );
            },
          )
        ],
      ),
    );
  }
}
