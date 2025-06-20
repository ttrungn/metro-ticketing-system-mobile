import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/text_input_field.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/logic/feedback_cubit.dart';

class NewFeedbackScreen extends StatefulWidget {
  const NewFeedbackScreen({super.key});

  @override
  State<NewFeedbackScreen> createState() => _NewFeedbackScreenState();
}

class _NewFeedbackScreenState extends State<NewFeedbackScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorText = 'Vui lòng nhập nội dung';
      });
      return;
    }

    // Clear lỗi
    setState(() => _errorText = null);

    context.read<FeedbackCubit>().submitFeedback(text).then((_) {
      Navigator.pop(context);
    });
  }

  final List<String> _feedbackTypes = ['Góp ý', 'Báo lỗi', 'Tính năng mới'];
  final List<String> _feedbackLocations = [
    'Ga A',
    'Ga B',
    'Ga C',
    'Ga D',
    'Ga E',
  ];

  String? _selectedType;
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gửi phản hồi',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Phản hồi về',
                prefixIcon: const Icon(
                  Icons.category,
                  color: ConstantAppColor.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: ConstantAppColor.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ConstantAppColor.primary,
                    width: 2,
                  ),
                ),
              ),
              value: _selectedType,
              items:
                  _feedbackTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Địa điểm',
                prefixIcon: const Icon(
                  Icons.train,
                  color: ConstantAppColor.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: ConstantAppColor.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ConstantAppColor.primary,
                    width: 2,
                  ),
                ),
              ),
              value: _selectedLocation,
              items:
                  _feedbackLocations
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextInputField(
              controller: _controller,
              focusNode: _focusNode,
              icon: Icons.feedback,
              labelText: 'Nội dung phản hồi',
              prefixIcon: Icons.feedback,
              errorText: _errorText,
              focusColor: ConstantAppColor.primary,
              unfocusColor: ConstantAppColor.primary,
            ),
            const SizedBox(height: 20),
            BlocBuilder<FeedbackCubit, FeedbackState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantAppColor.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  onPressed:
                      state is FeedbackLoading ? null : () => _submit(context),
                  child:
                      state is FeedbackLoading
                          ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                          : const Text('Gửi phản hồi'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}