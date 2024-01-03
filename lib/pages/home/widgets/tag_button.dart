import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/home/home_bloc.dart';
import 'package:real_world/bloc/home/home_state.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/sizes.dart';

class TagButton extends StatelessWidget {
  final String tag;
  final Function()? onTap;

  const TagButton({
    super.key,
    required this.tag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size2,
            horizontal: Sizes.size10,
          ),
          decoration: BoxDecoration(
            color: onTap == null
                ? null
                : state.tag == tag
                    ? Theme.of(context).primaryColor
                    : Colors.white,
            border: Border.all(
              width: Sizes.size1,
              color: onTap == null
                  ? Colors.grey.shade400
                  : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(Sizes.size20),
          ),
          child: AppFont(
            tag,
            style: TextStyle(
              color: onTap == null
                  ? Colors.grey.shade400
                  : state.tag == tag
                      ? Colors.white
                      : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
