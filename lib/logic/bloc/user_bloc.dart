// lib/logic/bloc/user_bloc.dart
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_shop/data/database/user_database.dart';
import 'package:watch_shop/logic/event/user_event.dart';
import 'package:watch_shop/logic/state/user_state.dart';

import '../../core/model/user_data.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDatabase db;

  UserBloc(this.db) : super(UserInitial()) {
    on<LoadUserEvent>(_onLoadUser);
    on<UpdateUserImageEvent>(_onUpdateUserImage); // Event جدید برای آپدیت عکس
  }

  Future<void> _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await db.getUser();
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError('کاربری یافت نشد'));
      }
    } catch (e) {
      emit(UserError('خطا در دریافت اطلاعات کاربر: $e'));
    }
  }

  Future<void> _onUpdateUserImage(UpdateUserImageEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      // فرض می‌کنیم حالت فعلی UserLoaded هست
      final currentState = state;
      if (currentState is! UserLoaded) {
        emit(UserError('کاربر لود نشده است'));
        return;
      }

      final user = currentState.user;

      // ذخیره عکس
      final permanentImagePath = await event.saveImagePermanently(File(event.imagePath));

      // آپدیت کاربر با مسیر عکس جدید
      final updatedUser = UserData(
        id: user.id,
        name: user.name,
        mobile: user.mobile,
        phone: user.phone,
        address: user.address,
        imagePaths: [permanentImagePath],
      );

      // ذخیره توی دیتابیس
      await db.insertUser(updatedUser);
      debugPrint('User updated with new image: $updatedUser');

      // emit حالت جدید
      emit(UserLoaded(updatedUser));
    } catch (e) {
      emit(UserError('خطا در آپدیت کاربر: $e'));
    }
  }
}