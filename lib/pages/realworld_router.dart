import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:real_world/bloc/signin/signin_bloc.dart';
import 'package:real_world/bloc/signup/signup_bloc.dart';
import 'package:real_world/pages/home/home_page.dart';
import 'package:real_world/pages/signin/signin_page.dart';
import 'package:real_world/pages/signup/signup_page.dart';
import 'package:real_world/repository/auth_repository.dart';

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
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => BlocProvider(
            create: (context) => SigninBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const SigninPage(),
          ),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => BlocProvider(
            create: (context) => SignupBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const SignupPage(),
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
