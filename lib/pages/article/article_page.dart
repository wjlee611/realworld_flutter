import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/article/article_bloc.dart';
import 'package:real_world/bloc/article/article_event.dart';
import 'package:real_world/bloc/article/article_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/models/article_model.dart';
import 'package:real_world/pages/article/widgets/author_widget.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('Article'),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        buildWhen: (previous, current) =>
            current.article == null ||
            current.articleStatus == ECommonStatus.loaded,
        builder: (context, state) {
          if (state.articleStatus == ECommonStatus.init) {
            context.read<ArticleBloc>().add(ArticleGetArticle());
          }
          if (state.articleStatus == ECommonStatus.error) {
            return Center(
              child: AppFont(state.message ?? 'N/A'),
            );
          }
          if (state.articleStatus != ECommonStatus.loaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildArticleBody(
            context,
            article: state.article!,
          );
        },
      ),
    );
  }

  Widget _buildArticleBody(
    BuildContext context, {
    required ArticleModel article,
  }) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFont(
                        article.title ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v16,
                      AuthorWidget(
                        author: article.author!,
                        createdAt: article.createdAt!,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.size20),
                child: AppFont(article.body ?? 'N/A'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Wrap(
                  runSpacing: Sizes.size5,
                  spacing: Sizes.size5,
                  alignment: WrapAlignment.end,
                  children: [
                    for (var tag in article.tagList ?? [])
                      Container(
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
                      ),
                  ],
                ),
              ),
              Gaps.v20,
              Container(
                width: double.infinity,
                height: Sizes.size1,
                color: Colors.grey.shade400,
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.size20),
                child: AuthorWidget(
                  author: article.author!,
                  createdAt: article.createdAt!,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: Placeholder(),
        ),
      ],
    );
  }
}
