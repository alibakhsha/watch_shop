// lib/presentation/widgets/profile.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import 'package:watch_shop/logic/bloc/image_picker_bloc.dart';
import 'package:watch_shop/logic/event/image_picker_event.dart';
import 'package:watch_shop/logic/state/image_picker_state.dart';
import 'package:watch_shop/gen/assets.gen.dart';

class CustomProfile extends StatelessWidget {
  final String? imagePath; // مسیر تصویر ذخیره‌شده (مثلاً از دیتابیس)
  final Function(String)? onImageChanged; // کال‌بک برای اطلاع دادن تغییر تصویر

  const CustomProfile({super.key, this.imagePath, this.onImageChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        File? imageFile;
        if (state is ImagePickedSuccess) {
          imageFile = state.image;

          if (onImageChanged != null && imageFile != null) {
            onImageChanged!(imageFile.path);
          }
        }

        return Column(
          children: [
            InkWell(
              onTap: () => _showImageSourceDialog(context),
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _getImageProvider(imageFile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text("انتخاب تصویر پروفایل", style: AppTextStyle.textFieldStyle),
          ],
        );
      },
    );
  }

  ImageProvider _getImageProvider(File? imageFile) {
    if (imageFile != null) {
      // اگه تصویر جدیدی انتخاب شده، از FileImage استفاده کن
      return FileImage(imageFile);
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      // اگه تصویر ذخیره‌شده وجود داره، از FileImage برای مسیر ذخیره‌شده استفاده کن
      return FileImage(File(imagePath!));
    } else {
      // در غیر این صورت، تصویر پیش‌فرض رو نمایش بده
      return AssetImage(Assets.png.user.path);
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(
                "انتخاب از گالری",
                style: AppTextStyle.textFieldStyle,
              ),
              onTap: () {
                context.read<ImagePickerBloc>().add(PickImageFromGallery());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text("گرفتن عکس", style: AppTextStyle.textFieldStyle),
              onTap: () {
                context.read<ImagePickerBloc>().add(PickImageFromCamera());
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
