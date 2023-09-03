import 'package:fithub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.isStarred,
    this.header,
    this.hint,
  });

  final TextEditingController controller;
  final bool isStarred;
  final String? header;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: header,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        isStarred
                            ? TextSpan(
                                text: "*",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: redColor,
                                    ),
                              )
                            : const TextSpan(),
                      ],
                    ),
                  ),
                )
              : Container(),
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
          ),
        ],
      ),
    );
  }
}
