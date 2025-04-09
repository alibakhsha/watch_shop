import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/core/database/user_database.dart';
import 'package:watch_shop/logic/bloc/user_bloc.dart';
import 'package:watch_shop/logic/event/user_event.dart';
import 'package:watch_shop/presentation/widgets/profile.dart';

import '../../core/model/user_data.dart';
import '../../core/utils/file_utils.dart';
import '../../logic/state/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserDatabase())..add(LoadUserEvent()),

      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final user = state.user;
            debugPrint(user.phone);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CustomProfile(
                    imagePath:
                        user.imagePaths?.isNotEmpty ?? false
                            ? user.imagePaths!.first
                            : null,
                    onImageChanged: (newImagePath) async {
                      final permanentImagePath =
                          await FileUtils.saveImagePermanently(
                            File(newImagePath),
                          );

                      final updatedUser = UserData(
                        id: user.id,
                        name: user.name,
                        mobile: user.mobile,
                        phone: user.phone,
                        address: user.address,
                        imagePaths: [permanentImagePath],
                      );

                      final db = UserDatabase();
                      await db.insertUser(updatedUser);
                      debugPrint('User updated with new image: $updatedUser');

                      context.read<UserBloc>().add(LoadUserEvent());
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: Text(user.phone)),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
