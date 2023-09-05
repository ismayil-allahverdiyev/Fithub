import 'package:fithub/core/routes/routes.dart';
import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/core/theme/assets.dart';
import 'package:fithub/features/homepage/view_model.dart/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: viewModel.listOfDays.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 5, 2),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.displayRoutine,
                    arguments: viewModel.listOfDays[index]);
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat.MMMMd()
                                .format(viewModel.listOfDays[index].date)
                                .split(" ")[1],
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            DateFormat.MMMMd()
                                .format(viewModel.listOfDays[index].date)
                                .split(" ")[0],
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          PercentIndicatorWidget(
                            index: 0,
                            percentage: viewModel.listOfDays[index].waterIntake,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          PercentIndicatorWidget(
                            index: 1,
                            percentage: viewModel.listOfDays[index].sleepHours,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          PercentIndicatorWidget(
                            index: 2,
                            percentage: 60,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          PercentIndicatorWidget(
                            index: 3,
                            percentage: 72,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 12, 0),
                      child: Column(
                        children: [
                          Text(
                            "72%",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Image.asset(
                            Assets.icon_trash,
                            scale: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class PercentIndicatorWidget extends StatelessWidget {
  const PercentIndicatorWidget({
    super.key,
    required this.index,
    required this.percentage,
  });

  final int index;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    final String icon = index == 0
        ? Assets.icon_fork_spoon
        : index == 1
            ? Assets.icon_moon
            : index == 2
                ? Assets.icon_foot
                : index == 3
                    ? Assets.icon_foot
                    : Assets.icon_fork_spoon;
    final Color color = index == 0
        ? lightOrange
        : index == 1
            ? lightBlue
            : index == 2
                ? lightGreen
                : index == 3
                    ? lightYellow
                    : whiteColor;

    return Row(
      children: [
        Image.asset(
          icon,
          scale: 2,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 4,
            child: Row(
              children: [
                Expanded(
                  flex: percentage,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: color,
                    ),
                  ),
                ),
                Expanded(
                  flex: 100 - percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: lightGreyColor,
                    ),
                    height: 4,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
