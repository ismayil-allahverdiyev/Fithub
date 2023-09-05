import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../../core/theme/app_colors.dart';
import '../../view_model/add_routine_view_model.dart';

class WaterIntakeWidget extends StatelessWidget {
  const WaterIntakeWidget({
    super.key,
    this.waterPercentage,
  });
  final int? waterPercentage;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "What was your water intake today?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lightGreyColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    Consumer<AddRoutineViewModel>(
                        builder: (context, viewModel, _) {
                      return Expanded(
                        flex: 10 +
                            90 *
                                (waterPercentage != null
                                    ? waterPercentage!
                                    : viewModel.waterPercentage) ~/
                                100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: WaveWidget(
                              waveAmplitude: 0,
                              wavePhase: 10,
                              config: CustomConfig(
                                gradients: [
                                  [
                                    Colors.blue,
                                    Color.fromARGB(237, 57, 158, 252)
                                  ],
                                  [
                                    Colors.blue[800]!,
                                    Color.fromARGB(119, 115, 151, 229)
                                  ],
                                  [
                                    const Color.fromARGB(255, 68, 233, 255),
                                    Color.fromARGB(102, 0, 179, 255)
                                  ],
                                  [
                                    Color.fromARGB(255, 59, 255, 203),
                                    Color.fromARGB(84, 59, 199, 255)
                                  ]
                                ],
                                durations: [35000, 19440, 10800, 6000],
                                heightPercentages: [
                                  0.0,
                                  0.000002,
                                  0.000003,
                                  0.000005
                                ],
                                gradientBegin: Alignment.bottomLeft,
                                gradientEnd: Alignment.topRight,
                              ),
                              size: Size(double.infinity, double.infinity),
                            ),
                          ),
                        ),
                      );
                    }),
                    Consumer<AddRoutineViewModel>(
                        builder: (context, viewModel, _) {
                      return Expanded(
                          flex: 10 +
                              90 *
                                  (90 -
                                      (waterPercentage != null
                                          ? waterPercentage!
                                          : viewModel.waterPercentage)) ~/
                                  100,
                          child: Container());
                    })
                  ],
                ),
              ),
              Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
                return Positioned(
                  left: 8,
                  child: Text(
                    "${waterPercentage != null ? waterPercentage! : viewModel.waterPercentage}%",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              }),
              Positioned(
                right: 8,
                child: Text(
                  "100%",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
        waterPercentage != null
            ? Container()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => primaryColor,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<AddRoutineViewModel>(context, listen: false)
                            .changeWaterIntake(isAdd: false);
                      },
                      child: const Icon(
                        Icons.remove,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => primaryColor,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Provider.of<AddRoutineViewModel>(context, listen: false)
                            .changeWaterIntake(isAdd: true);
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
