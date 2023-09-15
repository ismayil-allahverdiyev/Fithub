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
        actions: [
          Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
            print(viewModel.dateList.contains(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            )));
            print(viewModel.dateList);
            return viewModel.dateList.contains(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ))
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Updating today...",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  )
                : Container();
          }),
        ],
      ),
      body: ListView(
        children: [
          const CalendarWidget(),
          const MoodSelector(),
          const PlanListWidget(),
          const WaterIntakeWidget(),
          const SleepWidget(),
          Consumer2<HomeViewModel, AddRoutineViewModel>(
            builder: (context, homeViewModel, addRoutineViewModel, _) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  addRoutineViewModel.addRoutine().then((value) {
                    homeViewModel.updateListOfDays().then((value) {
                      addRoutineViewModel.getCalendarDate();
                    });
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
