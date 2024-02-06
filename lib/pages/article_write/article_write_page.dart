import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_world/bloc/article/write_article_bloc.dart';
import 'package:real_world/bloc/article/write_article_event.dart';
import 'package:real_world/bloc/article/write_article_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/common_text_form_widget.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/pages/article_write/widgets/article_write_tag_dialog.dart';

class ArticleWritePage extends StatelessWidget {
  const ArticleWritePage({super.key});

  void _onChangeTitle(
    BuildContext context, {
    required String text,
  }) {
    context.read<WriteArticleBloc>().add(WriteArticleChangeTitle(text));
  }

  void _onChangeDescription(
    BuildContext context, {
    required String text,
  }) {
    context.read<WriteArticleBloc>().add(WriteArticleChangeDescription(text));
  }

  void _onChangeBody(
    BuildContext context, {
    required String text,
  }) {
    context.read<WriteArticleBloc>().add(WriteArticleChangeBody(text));
  }

  void _onChangeTag(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<WriteArticleBloc>(context),
        child: const ArticleWriteTagDialog(),
      ),
    );
  }

  void _onTapSave(BuildContext context) {
    var bloc = context.read<WriteArticleBloc>();
    if (bloc.state.status == ECommonStatus.loading) {
      return;
    }
    bloc.add(WriteArticleUpload());
  }

  void _showSnackbar(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: AppFont(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size14,
            fontWeight: FontWeight.w700,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('Write Article'),
        centerTitle: false,
        actions: [
          BlocBuilder<WriteArticleBloc, WriteArticleState>(
            builder: (context, state) => IconButton.outlined(
              color: Theme.of(context).primaryColor,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.size5),
                ),
              ),
              onPressed: () => _onChangeTag(context),
              icon: Row(
                children: [
                  AppFont(
                    state.tagList.length.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Gaps.h3,
                  AppFont(
                    'Tags',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.h20,
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () => _onTapSave(context),
        child: Container(
          height: Sizes.size80,
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Center(
            child: BlocBuilder<WriteArticleBloc, WriteArticleState>(
                builder: (context, state) {
              if (state.status == ECommonStatus.loading) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }
              return const AppFont(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
          ),
        ),
      ),
      body: BlocListener<WriteArticleBloc, WriteArticleState>(
        listener: (context, state) {
          if (state.status == ECommonStatus.error) {
            _showSnackbar(
              context,
              message: state.message ?? 'Failed to save Article',
            );
          }
          if (state.status == ECommonStatus.loaded) {
            context.pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Gaps.v10,
              const AppFont('Title'),
              CommonTextForm(
                hint: 'Title',
                onChange: (text) => _onChangeTitle(
                  context,
                  text: text,
                ),
              ),
              Gaps.v10,
              const AppFont('Description'),
              CommonTextForm(
                hint: 'Description',
                onChange: (text) => _onChangeDescription(
                  context,
                  text: text,
                ),
              ),
              Gaps.v10,
              const AppFont('Body'),
              Expanded(
                child: CommonTextForm(
                  hint: 'Body',
                  expanded: true,
                  onChange: (text) => _onChangeBody(
                    context,
                    text: text,
                  ),
                ),
              ),
              Gaps.v40,
            ],
          ),
        ),
      ),
    );
  }
}
