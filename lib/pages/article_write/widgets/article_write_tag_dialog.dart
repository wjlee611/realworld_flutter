import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/article/write_article_bloc.dart';
import 'package:real_world/bloc/article/write_article_event.dart';
import 'package:real_world/bloc/article/write_article_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/common_text_form_widget.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/pages/article_write/widgets/aritcle_write_tag_button.dart';

class ArticleWriteTagDialog extends StatefulWidget {
  const ArticleWriteTagDialog({super.key});

  @override
  State<ArticleWriteTagDialog> createState() => _ArticleWriteTagDialogState();
}

class _ArticleWriteTagDialogState extends State<ArticleWriteTagDialog> {
  late final TextEditingController _controller;
  String tag = Strings.nullStr;

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

  void _onChangeTag(String text) {
    tag = text;
  }

  void _onAddTag() {
    context.read<WriteArticleBloc>().add(WriteArticleChangeAddTag(tag));
    _controller.clear();
    tag = Strings.nullStr;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size10),
          color: Colors.white,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Sizes.size10),
              child: AppFont(
                'Edit Tags',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BlocBuilder<WriteArticleBloc, WriteArticleState>(
                builder: (context, state) {
              if (state.tagList.isEmpty) {
                return const SizedBox(
                  height: Sizes.size32,
                  child: Center(
                    child: AppFont('no tags'),
                  ),
                );
              }
              return SizedBox(
                height: Sizes.size32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Gaps.h10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                  ),
                  itemBuilder: (context, index) => ArticleWriteTagButton(
                    tag: state.tagList[index],
                  ),
                  itemCount: state.tagList.length,
                ),
              );
            }),
            Gaps.v10,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CommonTextForm(
                      controller: _controller,
                      hint: 'Tag',
                      onChange: (text) => _onChangeTag(text),
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
                    onPressed: _onAddTag,
                    child: const AppFont('Add'),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Material(
              child: InkWell(
                onTap: context.pop,
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  padding: const EdgeInsets.all(Sizes.size10),
                  child: const Center(
                    child: AppFont(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
