import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/core/di/service_locator.dart';
import 'package:metro_ticketing_system_mobile/core/routes/app_routes.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/presentation/widgets/feedback_list.dart';
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart';
import 'package:metro_ticketing_system_mobile/features/user/logic/user_cubit.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: BlocProvider(
        create: (_) => UserCubit(getIt<UserService>()),
        child: const FeedbackList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantAppColor.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.feedback);
        },
      ),
    );
  }
}
