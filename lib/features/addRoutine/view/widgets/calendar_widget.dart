import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    this.date,
  });
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyMedium: appThemeData.textTheme.bodyMedium,
        ),
        colorScheme: appThemeData.colorScheme.copyWith(
          primary: primaryColor,
          onSecondary: Colors.red,
          inversePrimary: Colors.yellow,
          secondary: Colors.red,
        ),
      ),
      child: Consumer<AddRoutineViewModel>(
        builder: (context, viewModel, _) {
          return CalendarDatePicker(
            initialDate: viewModel.dateList.isEmpty
                ? DateTime.now()
                : !viewModel.dateList.contains(DateTime.now())
                    ? viewModel.dateList.last.add(
                        const Duration(
                          days: 1,
                        ),
                      )
                    : DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1, 1, 1),
            lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            onDateChanged: (value) {
              viewModel.setDate(value);
            },
            selectableDayPredicate: (day) {
              return !viewModel.dateList.contains(day);
            },
          );
        },
      ),
    );
  }
}
