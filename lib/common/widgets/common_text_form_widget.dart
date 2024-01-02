import 'package:flutter/material.dart';
import 'package:real_world/constants/sizes.dart';

class CommonTextForm extends StatelessWidget {
  final String hint;
  final Function(String value) onChange;

  const CommonTextForm({
    super.key,
    required this.hint,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
