import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SleepWidget extends StatelessWidget {
  const SleepWidget({
    super.key,
    this.sleepHours,
  });
  final double? sleepHours;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "How many hours did you sleep today?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
          return Slider.adaptive(
            value: sleepHours != null ? sleepHours! : viewModel.amountOfSleep,
            max: 12,
            min: 0,
            divisions: 12,
            label: sleepHours != null
                ? sleepHours!.toInt().toString()
                : viewModel.amountOfSleep.toInt().toString(),
            activeColor: primaryColor,
            secondaryTrackValue: 7,
            inactiveColor: lightPrimaryColor.withOpacity(0.2),
            onChanged: (value) {
              sleepHours != null
                  ? null
                  : viewModel.changeAmountOfSleep(amount: value);
            },
          );
        }),
      ],
    );
  }
}
