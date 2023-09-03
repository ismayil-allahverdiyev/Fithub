import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/sql_helper.dart';
import '../model/day_model.dart';

class HomeViewModel extends ChangeNotifier {
  var date = DateFormat.MMMMd().format(DateTime.now());

  List<DayModel> listOfDays = [];

  updateListOfDays() async {
    listOfDays.clear();
    var items = await SQLHelper.getItems();
    for (int i = 0; i < items.length; i++) {
      DayModel dayModel = DayModel.fromJson(items[i]);
      listOfDays.add(dayModel);
    }
    print(listOfDays.length);
    notifyListeners();
  }
}
