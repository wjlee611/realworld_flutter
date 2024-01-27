import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/comment/comment_bloc.dart';
import 'package:real_world/bloc/comment/comment_event.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/models/comment_model.dart';
import 'package:real_world/pages/article/widgets/comment_delete_dialog.dart';

class CommentItemWidget extends StatelessWidget {
  final CommentModel comment;

  const CommentItemWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: const LinearBorder(),
        padding: const EdgeInsets.all(Sizes.size20),
      ),
      onPressed: () {
        context.push('/profile/${comment.author?.username}');
      },
      onLongPress: () async {
        // TODO: Delete when author
        var authState = context.read<AuthBloc>().state;
        if (authState is AuthAuthenticatedState) {
          if (comment.author?.username == authState.user.username) {
            var isDelete = await showDialog(
              context: context,
              builder: (context_) {
                return const CommentDeleteDialog();
              },
            );

            if (isDelete == true) {
              context.read<CommentBloc>().add(CommentDelete(id: comment.id!));
            }
          }
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFont(comment.author?.username ?? ''),
            AppFont(
              comment.body ?? '',
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
