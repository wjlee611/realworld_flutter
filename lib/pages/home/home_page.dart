import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_event.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/auth_actions.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/pages/home/widgets/article_container.dart';
import 'package:real_world/pages/home/widgets/page_button.dart';
import 'package:real_world/pages/home/widgets/tag_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.tag == Strings.nullStr) {
              return const AppFont('RealWorld');
            }
            return GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(HomeChangeTag(Strings.nullStr));
              },
              child: Row(
                children: [
                  const Icon(Icons.cancel),
                  Gaps.h5,
                  Expanded(child: AppFont(state.tag)),
                ],
              ),
            );
          },
        ),
        centerTitle: false,
        actions: const [
          AuthActions(),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            previous.page != current.page || previous.tag != current.tag,
        listener: (context, state) {
          if (_controller.hasClients) {
            _controller.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        builder: (context, state) {
          if (state.articles.articles.isEmpty &&
              state.status == ECommonStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            controller: _controller,
            slivers: [
              SliverList.separated(
                itemBuilder: (context, index) => ArticleContainer(
                  article: state.articles.articles[index],
                ),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: Sizes.size1,
                  color: Colors.grey,
                ),
                itemCount: state.articles.articles.length,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const AppFont('Popular Tags'),
                          Gaps.v5,
                          Wrap(
                            spacing: Sizes.size5,
                            runSpacing: Sizes.size5,
                            children: [
                              for (var tag in state.tags)
                                TagButton(
                                  tag: tag,
                                  onTap: () {
                                    context
                                        .read<HomeBloc>()
                                        .add(HomeChangeTag(tag));
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: Sizes.size5,
                        children: [
                          for (int i = 0;
                              i < state.articles.articlesCount / HomeBloc.limit;
                              i++)
                            PageButton(page: i + 1),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
