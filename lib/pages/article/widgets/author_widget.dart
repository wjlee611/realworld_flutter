import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/article/article_bloc.dart';
import 'package:real_world/bloc/article/article_event.dart';
import 'package:real_world/bloc/article/article_state.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await context.push('/profile/${author.username}');
                context.read<ArticleBloc>().add(ArticleGetArticle());
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
        ),
        BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) => IconButton.outlined(
            color: color ?? Colors.white,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.size5),
              ),
            ),
            onPressed: () {
              if (context.read<AuthBloc>().state is! AuthAuthenticatedState) {
                context.push('/login');
                return;
              }

              if (state.articleStatus == ECommonStatus.loading) return;
              if (state.article?.author?.following == true) {
                context.read<ArticleBloc>().add(ArticleUnfollowUser());
              } else {
                context.read<ArticleBloc>().add(ArticleFollowUser());
              }
            },
            icon: Row(
              children: [
                Icon(
                  state.article?.author?.following == true
                      ? Icons.remove
                      : Icons.add,
                  size: Sizes.size16,
                ),
                Gaps.h3,
                AppFont(
                  state.article?.author?.following == true
                      ? 'Unfollow'
                      : 'Follow',
                  style: TextStyle(
                    color: color ?? Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
