import 'package:flutter/material.dart';
import 'package:real_world/constants/sizes.dart';

class CommonTextForm extends StatelessWidget {
  final String hint;
  final Function(String value) onChange;
  final String? initialValue;
  final TextEditingController? controller;
  final bool expanded;

  const CommonTextForm({
    super.key,
    required this.hint,
    required this.onChange,
    this.initialValue,
    this.controller,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(Sizes.size10),
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      expands: expanded,
      keyboardType: expanded ? TextInputType.multiline : null,
      minLines: null,
      maxLines: expanded ? null : 1,
      textAlignVertical: TextAlignVertical.top,
      onChanged: onChange,
    );
  }
}
