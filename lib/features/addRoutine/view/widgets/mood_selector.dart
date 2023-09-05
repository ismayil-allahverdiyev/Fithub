import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/assets.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    this.selectedMood,
  });
  final int? selectedMood;

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
                    if (selectedMood == null) viewModel.selectedMood = 0;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_sad,
                    color: selectedMood != null
                        ? selectedMood == 0
                            ? selectedYellowColor
                            : null
                        : viewModel.selectedMood == 0
                            ? selectedYellowColor
                            : null,
                    scale: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedMood == null) viewModel.selectedMood = 1;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_normal,
                    color: selectedMood != null
                        ? selectedMood == 1
                            ? selectedYellowColor
                            : null
                        : viewModel.selectedMood == 1
                            ? selectedYellowColor
                            : null,
                    scale: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedMood == null) viewModel.selectedMood = 2;
                  },
                  child: Image.asset(
                    Assets.icon_emoji_happy,
                    color: selectedMood != null
                        ? selectedMood == 2
                            ? selectedYellowColor
                            : null
                        : viewModel.selectedMood == 2
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
