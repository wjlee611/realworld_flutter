import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:real_world/bloc/article/article_bloc.dart';
import 'package:real_world/bloc/article/write_article_bloc.dart';
import 'package:real_world/bloc/authentication/auth_bloc.dart';
import 'package:real_world/bloc/authentication/auth_state.dart';
import 'package:real_world/bloc/comment/comment_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/profile/profile_cubit.dart';
import 'package:real_world/bloc/setting/setting_bloc.dart';
import 'package:real_world/bloc/signin/signin_bloc.dart';
import 'package:real_world/bloc/signup/signup_bloc.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/pages/article/article_page.dart';
import 'package:real_world/pages/article_write/article_write_page.dart';
import 'package:real_world/pages/home/home_page.dart';
import 'package:real_world/pages/profile/profile_page.dart';
import 'package:real_world/pages/setting/setting_page.dart';
import 'package:real_world/pages/signin/signin_page.dart';
import 'package:real_world/pages/signup/signup_page.dart';
import 'package:real_world/repository/article_repository.dart';
import 'package:real_world/repository/auth_repository.dart';
import 'package:real_world/repository/comment_repository.dart';
import 'package:real_world/repository/profile_repository.dart';

class RealWorldRouter extends StatefulWidget {
  const RealWorldRouter({super.key});

  @override
  State<RealWorldRouter> createState() => _RealWorldRouterState();
}

class _RealWorldRouterState extends State<RealWorldRouter> {
  late final GoRouter _routerConf;

  @override
  void initState() {
    super.initState();

    _routerConf = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
            create: (context) => HomeBloc(
              articleRepository: context.read<ArticleRepository>(),
            ),
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (context) => SigninBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const SigninPage(),
          ),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => BlocProvider(
            create: (context) => SignupBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const SignupPage(),
          ),
        ),
        GoRoute(
          path: '/profile/:username',
          builder: (context, state) => BlocProvider(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
            child: ProfilePage(
              username: state.pathParameters['username'] ?? Strings.nullStr,
            ),
          ),
        ),
        GoRoute(
          path: '/setting',
          builder: (context, state) => BlocProvider(
            create: (context) => SettingBloc(
              authRepository: context.read<AuthRepository>(),
              user: (context.read<AuthBloc>().state as AuthAuthenticatedState)
                  .user,
            ),
            child: const SettingPage(),
          ),
        ),
        GoRoute(
          path: '/article/:slug',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ArticleBloc(
                  slug: state.pathParameters['slug']!,
                  articleRepository: context.read<ArticleRepository>(),
                  profileRepository: context.read<ProfileRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => CommentBloc(
                  commentRepository: context.read<CommentRepository>(),
                  slug: state.pathParameters['slug']!,
                ),
              ),
            ],
            child: const ArticlePage(),
          ),
        ),
        GoRoute(
          path: '/write_article',
          builder: (context, state) => BlocProvider(
            create: (context) => WriteArticleBloc(
              articleRepository: context.read<ArticleRepository>(),
            ),
            child: const ArticleWritePage(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _routerConf,
      debugShowCheckedModeBanner: false,
      title: 'RealWorld Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
