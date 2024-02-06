import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/comment/comment_bloc.dart';
import 'package:real_world/bloc/comment/comment_event.dart';
import 'package:real_world/bloc/comment/comment_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/common_text_form_widget.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChange(BuildContext context, String value) {
    context.read<CommentBloc>().add(CommentChange(value));
  }

  void _onSend(BuildContext context) {
    context.read<CommentBloc>().add(CommentAdd());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
            vertical: Sizes.size10,
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is! AuthAuthenticatedState) {
                return ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Sizes.size5,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const AppFont('Sign in to add comment!'),
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: CommonTextForm(
                      controller: _controller,
                      hint: 'Add Comment!',
                      onChange: (value) => _onChange(context, value),
                    ),
                  ),
                  Gaps.h10,
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size5,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () => _onSend(context),
                    child: const AppFont('Add'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
