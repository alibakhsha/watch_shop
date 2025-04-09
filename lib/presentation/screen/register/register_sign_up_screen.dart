import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/core/database/user_database.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/logic/bloc/register_bloc.dart';
import 'package:watch_shop/logic/state/image_picker_state.dart';
import 'package:watch_shop/presentation/widgets/custom_button.dart';
import 'package:watch_shop/presentation/widgets/avatar.dart';
import 'package:watch_shop/presentation/widgets/text_fields.dart';
import 'package:watch_shop/services/api_sevice.dart';

import '../../../core/utils/file_utils.dart';
import '../../../logic/bloc/image_picker_bloc.dart';
import '../../../logic/event/register_event.dart';
import '../../../logic/state/register_state.dart';
import '../../widgets/app_bar.dart';

class RegisterSignUpScreen extends StatelessWidget {
  const RegisterSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterBloc(ApiService()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.bgColor,
          appBar: buildCustomSignUpAppBar(() {
            GoRouter.of(context).pop();
          }),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 42.w, left: 42.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    CustomAvatar(title: "انتخاب تصویر پروفایل"),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      text: "نام و نام خانوادگی",
                      hintText:
                          "نام و نام خانوادگی خود را با حروف فارسی وارد کنید",
                      controller: nameController,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      text: "تلفن ثابت",
                      hintText: "شماره تلفن ثابت را با پیش شماره وارد بفرمایید",
                      controller: phoneController,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      text: "آدرس",
                      hintText: "آدرس پستی خود را وارد کنید",
                      controller: addressController,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      text: "کد پستی",
                      hintText: "کد پستی  10 رقمی خود را وارد کنید",
                      controller: postalCodeController,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      text: "موقعیت مکانی",
                      hintText: "برای انتخاب موقعیت مکانی ضربه برنید",
                      controller: TextEditingController(),
                      hasIcon: true,
                    ),
                    SizedBox(height: 24.h),
                    BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) async {
                        if (state is RegisterSuccess) {
                          debugPrint('RegisterSuccess state: $state');
                          debugPrint('Message: ${state.message}');
                          debugPrint('User: ${state.user}');
                          final userData = state.user;
                          debugPrint('Image Paths: ${state.user.imagePaths}');
                          debugPrint('UserData: $userData');

                          // ذخیره کاربر توی SQLite
                          final db = UserDatabase();
                          await db.insertUser(userData);
                          debugPrint('User saved in SQLite: $userData');

                          GoRouter.of(context).pushReplacement(RouteName.home);
                        }
                        if (state is RegisterFailure) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return CircularProgressIndicator();
                        }

                        return CustomButton(
                          text: "ثبت نام",
                          onPressed: () async {
                            final name = nameController.text;
                            final phone = phoneController.text;
                            final address = addressController.text;
                            final postalCode = postalCodeController.text;
                            final imageFile =
                                context.read<ImagePickerBloc>().state
                                        is ImagePickedSuccess
                                    ? (context.read<ImagePickerBloc>().state
                                            as ImagePickedSuccess)
                                        .image
                                    : null;

                            String? permanentImagePath;
                            if (imageFile != null) {
                              permanentImagePath =
                                  await FileUtils.saveImagePermanently(
                                    imageFile,
                                  );
                            }

                            final registerEvent = RegisterUserEvent(
                              name: name,
                              phone: phone,
                              address: address,
                              postalCode: postalCode,
                              lat: 12.90,
                              lng: 11.1,
                              imagePaths:
                                  permanentImagePath != null
                                      ? [permanentImagePath]
                                      : null,
                            );

                            context.read<RegisterBloc>().add(registerEvent);
                          },
                          shape: ButtonShape.rectangle,
                          fullWidth: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
