import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/assets.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Text(
            "How is your mood today?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Consumer<AddRoutineViewModel>(
          builder: (context, viewModel, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.selectedMood = 0;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_sad,
                    color: viewModel.selectedMood == 0
                        ? selectedYellowColor
                        : null,
                    scale: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.selectedMood = 1;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_normal,
                    color: viewModel.selectedMood == 1
                        ? selectedYellowColor
                        : null,
                    scale: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    viewModel.selectedMood = 2;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_happy,
                    color: viewModel.selectedMood == 2
                        ? selectedYellowColor
                        : null,
                    scale: 2,
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
