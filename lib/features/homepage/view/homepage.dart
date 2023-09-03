import 'package:fithub/core/theme/app_colors.dart';
import 'package:fithub/features/homepage/view/widgets/main_body_widget.dart';
import 'package:fithub/features/homepage/view/widgets/upper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          UpperBody(),
          CustomDivider(),
          MainBody(),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Divider(
      endIndent: width / 4,
      indent: width / 4,
      thickness: 2,
      color: greyColor,
    );
  }
}
