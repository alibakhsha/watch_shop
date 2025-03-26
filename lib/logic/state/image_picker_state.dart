import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ImagePickerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImagePickerState {}

class ImagePickedSuccess extends ImagePickerState {
  final File image;
  ImagePickedSuccess({required this.image});

  @override
  List<Object?> get props => [image];
}

class ImagePickedFailure extends ImagePickerState {
  final String error;
  ImagePickedFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
