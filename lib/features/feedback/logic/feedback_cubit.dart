import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_model.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_request.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';

@injectable
class FeedbackCubit extends Cubit<FeedbackState> {
  final UserService _userService;
  FeedbackCubit(this._userService) : super(FeedbackInitial());

  Future<void> fetchFeedbacks() async {
    try {
      emit(FeedbackLoading());
      final feedbacks = await _userService.fetchFeedbacks();
      emit(FeedbackLoaded(feedbacks));
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }

  Future<void> submitFeedback(FeedbackRequest request) async {
    try {
      emit(FeedbackLoading());
      print(request);
      await _userService.submitFeedback(request);
      emit(FeedbackInitial());
    } catch (_) {
      emit(FeedbackError("Gửi phản hồi thất bại"));
    }
  }
}

@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {
  final List<FeedbackModel> feedbacks;
  FeedbackLoaded(this.feedbacks);
}

class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError(this.message);
}
