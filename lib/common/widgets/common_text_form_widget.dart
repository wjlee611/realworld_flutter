import 'package:flutter/material.dart';
import 'package:real_world/constants/sizes.dart';

class CommonTextForm extends StatelessWidget {
  final String hint;
  final Function(String value) onChange;
  final String? initialValue;

  const CommonTextForm({
    super.key,
    required this.hint,
    required this.onChange,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size1,
          horizontal: Sizes.size10,
        ),
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChange,
    );
  }
}
