import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_world/bloc/profile/profile_cubit.dart';
import 'package:real_world/common/enum/common_status_enum.dart';
import 'package:real_world/common/widgets/app_font.dart';
import 'package:real_world/constants/gaps.dart';
import 'package:real_world/constants/sizes.dart';
import 'package:real_world/constants/strings.dart';
import 'package:real_world/models/profile_model.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('Profile'),
        centerTitle: true,
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) => IconButton.outlined(
              color: Theme.of(context).primaryColor,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.size5),
                ),
              ),
              onPressed: () {
                if (state.status == ECommonStatus.loading) return;
                if (state.profile?.following == true) {
                  context.read<ProfileCubit>().unfollowUser();
                } else {
                  context.read<ProfileCubit>().followUser();
                }
              },
              icon: Row(
                children: [
                  Icon(
                    state.profile?.following == true ? Icons.remove : Icons.add,
                    size: Sizes.size16,
                  ),
                  Gaps.h3,
                  AppFont(
                    state.profile?.following == true ? 'Unfollow' : 'Follow',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.h10,
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) =>
            current.profile == null || current.status == ECommonStatus.loaded,
        builder: (context, state) {
          if (state.status == ECommonStatus.init) {
            context.read<ProfileCubit>().getProfile(username);
          }
          if (state.status == ECommonStatus.error) {
            return Center(
              child: AppFont(state.message ?? Strings.nullStr),
            );
          }
          if (state.status == ECommonStatus.loaded) {
            return _buildBody(
              context,
              profile: state.profile!,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    required ProfileModel profile,
  }) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.size20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppFont('Username'),
          AppFont(
            profile.username ?? 'N/A',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Sizes.size20,
            ),
          ),
          Gaps.v10,
          const AppFont('Bio'),
          AppFont(
            profile.bio ?? 'N/A',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
