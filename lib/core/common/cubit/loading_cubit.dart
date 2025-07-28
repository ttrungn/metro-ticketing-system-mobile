import 'package:flutter_bloc/flutter_bloc.dart';

final class LoadingState {
  final bool isLoading;

  const LoadingState({required this.isLoading});
}

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingState(isLoading: false));

  void show() => emit(LoadingState(isLoading: true));
  void hide() => emit(LoadingState(isLoading: false));
}
