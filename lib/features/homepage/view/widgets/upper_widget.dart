import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/features/homepage/view_model.dart/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/routes.dart';

class UpperBody extends StatelessWidget {
  const UpperBody({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: height / 3,
          child: Center(
            child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.date.split(" ")[1],
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    viewModel.date.split(" ")[0],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              );
            }),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.addRoutine);
            },
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.add,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
