import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/models/profile_model.dart';

class AuthorWidget extends StatelessWidget {
  final ProfileModel author;
  final DateTime createdAt;
  final Color? color;

  const AuthorWidget({
    super.key,
    required this.author,
    required this.createdAt,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.push('/profile/${author.username}');
          },
          child: AppFont(
            author.username ?? 'N/A',
            style: TextStyle(
              color: color ?? Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
        AppFont(
          createdAt.toString(),
          style: TextStyle(
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}
