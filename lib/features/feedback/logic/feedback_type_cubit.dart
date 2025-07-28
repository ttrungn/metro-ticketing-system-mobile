import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_type.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/station_model.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';

@injectable
class FeedbackTypeCubit extends Cubit<FeedbackTypeState> {
  final UserService _userService;
  FeedbackTypeCubit(this._userService) : super(FeedbackTypeInitial());

  Future<void> fetchFeedbackTypesAndStations() async {
    emit(FeedbackTypeLoading());
    try {
      final feedbackTypes = await _userService.fetchFeedbackTypes();
      final stations = await _userService.fetchStations();

      emit(
        FeedbackTypeLoaded(feedbackTypes: feedbackTypes, stations: stations),
      );
    } catch (e) {
      emit(FeedbackTypeError(e.toString()));
    }
  }
}

@immutable
abstract class FeedbackTypeState {}

class FeedbackTypeInitial extends FeedbackTypeState {}

class FeedbackTypeLoading extends FeedbackTypeState {}

class FeedbackTypeLoaded extends FeedbackTypeState {
  final List<FeedbackType> feedbackTypes;
  final List<StationModel> stations;

  FeedbackTypeLoaded({required this.feedbackTypes, required this.stations});
}

class FeedbackTypeError extends FeedbackTypeState {
  final String message;
  FeedbackTypeError(this.message);
}
