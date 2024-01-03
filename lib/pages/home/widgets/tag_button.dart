import 'package:flutter/material.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';

class TagButton extends StatelessWidget {
  final String tag;

  const TagButton({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: Sizes.size1,
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(Sizes.size20),
      ),
      child: AppFont(
        tag,
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
