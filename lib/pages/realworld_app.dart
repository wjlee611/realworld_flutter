import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:real_world/pages/home/home_page.dart';

class RealWorldApp extends StatefulWidget {
  const RealWorldApp({super.key});

  @override
  State<RealWorldApp> createState() => _RealWorldAppState();
}

class _RealWorldAppState extends State<RealWorldApp> {
  late final GoRouter _routerConf;

  @override
  void initState() {
    super.initState();

    _routerConf = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
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
