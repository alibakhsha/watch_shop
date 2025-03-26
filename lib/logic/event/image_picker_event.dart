import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageFromGallery extends ImagePickerEvent {}

class PickImageFromCamera extends ImagePickerEvent {}
