import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/logic/feedback_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/screens/new_feedback_screen.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/widgets/feedback_list.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: BlocProvider(
        create: (_) => FeedbackCubit(getIt<UserService>())..fetchFeedbacks(),
        child: const FeedbackList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantAppColor.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider(
                    create: (_) => FeedbackCubit(getIt<UserService>()),
                    child: const NewFeedbackScreen(),
                  ),
            ),
          );
        },
      ),
    );
  }
}