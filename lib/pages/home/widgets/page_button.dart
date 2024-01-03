import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_event.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/widgets/app_font.dart';

class PageButton extends StatelessWidget {
  final int page;

  const PageButton({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              page == state.page ? Theme.of(context).primaryColor : null,
          foregroundColor: page == state.page ? Colors.white : null,
        ),
        onPressed: () {
          context.read<HomeBloc>().add(HomeGetArticles(
                page: page,
              ));
        },
        child: AppFont(
          page.toString(),
        ),
      ),
    );
  }
}
