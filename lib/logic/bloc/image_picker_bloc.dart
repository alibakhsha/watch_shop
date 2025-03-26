import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../event/image_picker_event.dart';
import '../state/image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(ImageInitial()) {
    on<PickImageFromGallery>(_pickImageFromGallery);
    on<PickImageFromCamera>(_pickImageFromCamera);
  }

  Future<void> _pickImageFromGallery(
      PickImageFromGallery event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImagePickedSuccess(image: File(pickedFile.path)));
      } else {
        emit(ImagePickedFailure(error: "هیچ تصویری انتخاب نشد."));
      }
    } catch (e) {
      emit(ImagePickedFailure(error: "خطا در انتخاب تصویر: $e"));
    }
  }

  Future<void> _pickImageFromCamera(
      PickImageFromCamera event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        emit(ImagePickedSuccess(image: File(pickedFile.path)));
      } else {
        emit(ImagePickedFailure(error: "هیچ تصویری گرفته نشد."));
      }
    } catch (e) {
      emit(ImagePickedFailure(error: "خطا در گرفتن تصویر: $e"));
    }
  }
}
