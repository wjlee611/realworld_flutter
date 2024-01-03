import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/common/widgets/auth_actions.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/pages/home/widgets/article_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('RealWorld'),
        actions: const [
          AuthActions(),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => CustomScrollView(
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
              child: AppFont(
                state.articles.articlesCount.toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
