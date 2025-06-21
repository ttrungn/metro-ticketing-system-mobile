import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/text_input_field.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/data/models/feedback_request.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/logic/feedback_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/feedback/logic/feedback_type_cubit.dart';


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

    if (_selectedType == null) {
      setState(() {
        _errorText = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn loại phản hồi')),
      );
      return;
    }

    if (_selectedLocation == null) {
      setState(() {
        _errorText = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn trạm')),
      );
      return;
    }

    if (text.isEmpty) {
      setState(() {
        _errorText = 'Vui lòng nhập nội dung';
      });
      return;
    }

    setState(() => _errorText = null);

    final request = FeedbackRequest(
      type: _selectedType!,
      station: _selectedLocation!,
      content: text,
    );

    context.read<FeedbackCubit>().submitFeedback(request).then((_) {
      Navigator.pop(context, true);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gửi phản hồi thất bại: $error')),
      );
    });
  }


  String? _selectedType;
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    context.read<FeedbackTypeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gửi phản hồi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: ConstantAppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<FeedbackTypeCubit, FeedbackTypeState>(
              builder: (context, state) {
                if (state is FeedbackTypeLoading) {
                  return const CircularProgressIndicator();
                }

                if (state is FeedbackTypeLoaded) {
                  final feedbackTypes = state.feedbackTypes;
                  final stations = state.stations;

                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Loại phản hồi',
                          labelStyle: const TextStyle(
                              color: ConstantAppColor.primary,
                              fontWeight: FontWeight.bold
                          ),
                          prefixIcon: const Icon(
                              Icons.category,
                              color: ConstantAppColor.primary
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: ConstantAppColor.primary,
                              width: 1.5,
                            ),
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
                        items: feedbackTypes.map((type) => DropdownMenuItem(
                          value: type.id,
                          child: Text(type.name),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Chọn trạm',
                          labelStyle: const TextStyle(
                              color: ConstantAppColor.primary,
                              fontWeight: FontWeight.bold
                          ),
                          prefixIcon: const Icon(
                              Icons.train,
                              color: ConstantAppColor.primary
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: ConstantAppColor.primary,
                              width: 1.5,
                            ),
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
                        items: stations.map((station) => DropdownMenuItem(
                          value: station.id,
                          child: Text(station.name),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLocation = value;
                          });
                        },
                      ),
                    ],
                  );
                }

                if (state is FeedbackTypeError) {
                  return Text('Lỗi: ${state.message}');
                }

                return const SizedBox.shrink();
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