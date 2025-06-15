import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_model.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/logic/feedback_cubit.dart';

import '../../../../core/constants/app_color.dart';

class FeedbackList extends StatefulWidget {
  const FeedbackList({super.key});

  @override
  State<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      builder: (context, state) {
        if (state is FeedbackLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeedbackError) {
          return Center(child: Text('Lỗi: ${state.message}'));
        } else if (state is FeedbackLoaded) {
          final List<FeedbackModel> feedbacks = state.feedbacks;
          if (feedbacks.isEmpty) {
            return const Center(child: Text('Chưa có phản hồi nào.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: feedbacks.length,
            separatorBuilder:
                (_, __) => const Divider(color: ConstantAppColor.primary),
            itemBuilder: (context, index) {
              final feedback = feedbacks[index];
              return ListTile(
                leading: const Icon(
                  Icons.feedback,
                  color: ConstantAppColor.primary,
                ),
                title: Text(
                  feedback.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ConstantAppColor.primary,
                  ),
                ),
                subtitle: Text(
                  '${feedback.location}: ${feedback.content}',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink(); // fallback
      },
    );
  }
}