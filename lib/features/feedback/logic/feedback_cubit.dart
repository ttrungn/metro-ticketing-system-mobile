import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_model.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';

@injectable
class FeedbackCubit extends Cubit<FeedbackState> {
  final UserService _userService;
  FeedbackCubit(this._userService) : super(FeedbackInitial());

  Future<void> fetchFeedbacks() async {
    try {
      emit(FeedbackLoading());
      await Future.delayed(Duration(seconds: 2));
      final feedbacks = List<FeedbackModel>.generate(
        10,
        (index) => FeedbackModel(
          type: 'Feedback Type $index',
          location: 'Location $index',
          content: 'This is feedback content number $index',
        ),
      );
      emit(FeedbackLoaded(feedbacks));
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }

  Future<void> submitFeedback(String content) async {
    try {
      emit(FeedbackLoading());
      // await _service.sendFeedback(content);
      // await getUserFeedbacks();
      await Future.delayed(Duration(seconds: 2));
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
  final List<FeedbackModel>
  feedbacks; // Replace with your actual feedback model
  FeedbackLoaded(this.feedbacks);
}

class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError(this.message);
}