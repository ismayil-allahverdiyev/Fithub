import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Time",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: "*",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: redColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 8,
            ),
            Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
              return InkWell(
                onTap: () {
                  viewModel.selectTime(context: context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGreyColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              viewModel.selectedTime!.hour.toString(),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        ":",
                      ),
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              viewModel.selectedTime!.minute.toString(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        )
      ],
    );
  }
}
