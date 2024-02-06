import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/article/write_article_bloc.dart';
import 'package:real_world/bloc/article/write_article_event.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';

class ArticleWriteTagButton extends StatelessWidget {
  final String tag;

  const ArticleWriteTagButton({
    super.key,
    required this.tag,
  });

  void _onTap(BuildContext context) {
    context.read<WriteArticleBloc>().add(WriteArticleChangeRemoveTag(tag));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(Sizes.size20),
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size5,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: Sizes.size1,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(Sizes.size20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.cancel,
                size: Sizes.size16,
              ),
              Gaps.h3,
              AppFont(tag),
            ],
          ),
        ),
      ),
    );
  }
}
