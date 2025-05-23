// lib/logic/event/image_picker_event.dart
import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageFromGallery extends ImagePickerEvent {}

class PickImageFromCamera extends ImagePickerEvent {}

class ResetImagePicker extends ImagePickerEvent {} // Event جدید