import 'package:fithub/core/utils/utils.dart';
import 'package:fithub/features/addRoutine/view/widgets/time_selector_widget.dart';
import 'package:fithub/features/addRoutine/view_model/add_routine_view_model.dart';
import 'package:fithub/features/commonWidgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/assets.dart';
import '../../model/plan_model.dart';

class PlanListWidget extends StatelessWidget {
  const PlanListWidget({
    super.key,
    this.planList,
  });
  final List<PlanModel>? planList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            "What is your plan for today?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: lightGreyColor, width: 1.5),
            ),
            child:
                Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: planList != null
                    ? planList!.length
                    : viewModel.planList.length,
                itemBuilder: (context, index) {
                  return ListComponentWidget(
                    index: planList != null ? null : index,
                    planModel: planList != null
                        ? planList![index]
                        : viewModel.planList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                  );
                },
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
              return ElevatedButton(
                onPressed: () {
                  viewModel.prepareTheBottomSheet(index: -1);
                  customBottomSheet(
                    context: context,
                    isEdit: false,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => primaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icon_add_circle,
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Add",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: whiteColor,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ],
    );
  }
}

Future<dynamic> customBottomSheet({
  required BuildContext context,
  required bool isEdit,
  int? index,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    builder: (context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Stack(
          children: [
            SizedBox(
              height: height / 2,
              child: ListView(
                children: [
                  Consumer<AddRoutineViewModel>(
                    builder: (context, viewModel, child) => CustomTextField(
                      controller: viewModel.planController,
                      isStarred: true,
                      header: "Your plan",
                      hint: "Enter a plan...",
                    ),
                  ),
                  const TimeSelector(),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Consumer<AddRoutineViewModel>(
                  builder: (context, viewModel, _) {
                return GestureDetector(
                  onTap: () {
                    if (isEdit) {
                      viewModel.editTheList(index: index!);
                      Navigator.pop(context);
                    } else {
                      viewModel.saveToTheList();
                      Navigator.pop(context);
                    }
                  },
                  child: CircleAvatar(
                    radius: width * 0.075,
                    backgroundColor: primaryColor,
                    child: Center(
                      child: Image.asset(
                        Assets.icon_add_circle,
                        scale: 2,
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    },
  );
}

class ListComponentWidget extends StatelessWidget {
  const ListComponentWidget({super.key, required this.planModel, this.index});
  final PlanModel planModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddRoutineViewModel>(builder: (context, viewModel, _) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${planModel.timeOfDay.hour}:${planModel.timeOfDay.minute} ${planModel.timeOfDay.period.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    planModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          index == null
              ? Container()
              : Row(
                  children: [
                    InkWell(
                      onTap: () {
                        viewModel.prepareTheBottomSheet(index: index!);
                        customBottomSheet(
                            context: context, isEdit: true, index: index);
                      },
                      child: Image.asset(
                        Assets.icon_edit,
                        scale: 1.5,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        viewModel.deleteFromTheList(index: index!);
                      },
                      child: Image.asset(
                        Assets.icon_trash2,
                        scale: 1.5,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                )
        ],
      );
    });
  }
}
