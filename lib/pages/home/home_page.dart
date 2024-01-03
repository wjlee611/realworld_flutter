import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/auth_actions.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/pages/home/widgets/article_container.dart';
import 'package:real_world/pages/home/widgets/page_button.dart';

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
        title: const AppFont('RealWorld'),
        actions: const [
          AuthActions(),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state.status == ECommonStatus.loaded) {
          if (_controller.hasClients) {
            _controller.animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          }
        }
      }, builder: (context, state) {
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
      }),
    );
  }
}
