import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/constant/app_text_style.dart';
import '../../logic/bloc/image_picker_bloc.dart';
import '../../logic/event/image_picker_event.dart';
import '../../logic/state/image_picker_state.dart';
import '../../../gen/assets.gen.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        File? imageFile;
        if (state is ImagePickedSuccess) {
          imageFile = state.image;
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
                    image: imageFile != null
                        ? FileImage(imageFile) as ImageProvider
                        : AssetImage(Assets.png.user.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text("انتخاب تصویر پروفایل",style: AppTextStyle.textFieldStyle),
          ],
        );
      },
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("انتخاب از گالری",style: AppTextStyle.textFieldStyle,),
              onTap: () {
                context.read<ImagePickerBloc>().add(PickImageFromGallery());
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("گرفتن عکس",style: AppTextStyle.textFieldStyle),
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
