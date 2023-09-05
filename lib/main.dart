import 'package:fithub/core/routes/routes.dart';
import 'package:fithub/core/theme/theme.dart';
import 'package:fithub/features/addRoutine/view/add_routine.dart';
import 'package:fithub/features/display/view/display_routine_view.dart';
import 'package:fithub/features/homepage/model/day_model.dart';
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
        onGenerateRoute: (RouteSettings settings) {
          print('build route for ${settings.name}');
          var routes = <String, WidgetBuilder>{
            '/': (context) => const HomePage(),
            Routes.addRoutine: (context) => const AddRoutine(),
            Routes.displayRoutine: (context) =>
                DisplayRoutineView(dayModel: settings.arguments as DayModel),
          };
          WidgetBuilder builder = routes[settings.name]!;
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    ),
  );
}
