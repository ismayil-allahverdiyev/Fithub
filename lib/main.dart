import 'package:fithub/core/routes/routes.dart';
import 'package:fithub/core/theme/theme.dart';
import 'package:fithub/features/addRoutine/view/add_routine.dart';
import 'package:fithub/features/homepage/view_model.dart/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/addRoutine/view_model/add_routine_view_model.dart';
import 'features/homepage/view/homepage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<AddRoutineViewModel>(
            create: (_) => AddRoutineViewModel()),
      ],
      child: MaterialApp(
        theme: appThemeData,
        routes: {
          '/': (context) => const HomePage(),
          Routes.addRoutine: (context) => const AddRoutine(),
        },
      ),
    ),
  );
}
