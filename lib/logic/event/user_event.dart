// lib/logic/event/user_event.dart
import 'dart:io';

abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateUserImageEvent extends UserEvent {
  final String imagePath;
  final Future<String> Function(File) saveImagePermanently;

  UpdateUserImageEvent(this.imagePath, this.saveImagePermanently);
}