import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/models/profile_info.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  final UserService _userService;

  UserCubit(this._userService) : super(UserInitial());

  Future<void> getUserInfo() async {
    try {
      emit(UserLoading());
      final userInfo = await _userService.getUserInfo();
      emit(UserLoaded(userInfo));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final ProfileInfo userInfo;
  UserLoaded(this.userInfo);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}