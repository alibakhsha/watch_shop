import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/data/database/user_database.dart';
import 'package:watch_shop/gen/assets.gen.dart';
import 'package:watch_shop/logic/bloc/user_bloc.dart';
import 'package:watch_shop/logic/event/user_event.dart';
import 'package:watch_shop/presentation/widgets/avatar.dart';

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
            return Padding(
              padding: EdgeInsets.fromLTRB(24.w, 36.h, 24.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAvatar(
                    title: user.name,
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

                      // ignore: use_build_context_synchronously
                      context.read<UserBloc>().add(LoadUserEvent());
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildInformationSection(user),
                  SizedBox(height: 20.h),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColor.profileBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Text(
                          "قوانین و مقررات",
                          style: AppTextStyle.profileTextStyle1,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),
                  _buildPurchaseStatusSection(),
                  SizedBox(height: 8.h),
                  Container(
                    height: 116.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: AssetImage(Assets.png.profileBanner.path,),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildInformationSection(UserData user) {
    return Column(
      children: [
        Row(
          children: [Text("آدرس فعال", style: AppTextStyle.profileTextStyle1)],
        ),
        SizedBox(height: 8.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              user.address.address,
              style: AppTextStyle.profileTextStyle1,
              overflow: TextOverflow.ellipsis,
            ),
            SvgPicture.asset(Assets.svg.vuesaxLinearDirectLeft),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SvgPicture.asset(Assets.svg.group255),
            SizedBox(width: 4.w),
            Text(
              user.address.postalCode,
              style: AppTextStyle.profileTextStyle1,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SvgPicture.asset(Assets.svg.group256),
            SizedBox(width: 4.w),
            Text(user.mobile, style: AppTextStyle.profileTextStyle1),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            SvgPicture.asset(Assets.svg.group257),
            SizedBox(width: 4.w),
            Text(user.name, style: AppTextStyle.profileTextStyle1),
          ],
        ),
      ],
    );
  }
  Widget _buildPurchaseStatusSection(){
    return Container(
      height: 164.h,
      decoration: BoxDecoration(
        color: AppColor.profileBoxColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svg.group246),
              SizedBox(height: 12.h),
              Text(
                "درحال پردازش",
                style: AppTextStyle.profileTextStyle1,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svg.group244),
              SizedBox(height: 12.h),
              Text(
                "لغو شده",
                style: AppTextStyle.profileTextStyle1,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svg.group245),
              SizedBox(height: 12.h),
              Text(
                "تحویل شده",
                style: AppTextStyle.profileTextStyle1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
