import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/database/user_database.dart';
import '../event/user_event.dart';
import '../state/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDatabase db;

  UserBloc(this.db) : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await db.getUser();
        emit(UserLoaded(user!));
      } catch (e) {
        emit(UserError("خطا در دریافت اطلاعات کاربر"));
      }
    });
  }
}
