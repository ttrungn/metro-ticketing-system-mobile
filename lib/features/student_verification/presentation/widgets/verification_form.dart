import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/logic/verification_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/student_verification/presentation/widgets/submit_button.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentCodeController = TextEditingController();
  final _studentEmailController = TextEditingController();
  final _schoolController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  // final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();

  File? _studentCardImage;

  final FocusNode _studentCodeFocusNode = FocusNode();
  final FocusNode _schoolFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  // final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _studentEmailFocusNode = FocusNode();

  final Color _focusColor = ConstantAppColor.primary;
  final Color _unfocusColor = Colors.grey[400]!;

  @override
  void initState() {
    super.initState();
    _studentCodeFocusNode.addListener(() => setState(() {}));
    _schoolFocusNode.addListener(() => setState(() {}));
    _firstNameFocusNode.addListener(() => setState(() {}));
    _lastNameFocusNode.addListener(() => setState(() {}));
    // _fullNameFocusNode.addListener(() => setState(() {}));
    _studentEmailFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _studentCodeFocusNode.dispose();
    _studentEmailFocusNode.dispose();
    _schoolFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    // _fullNameController.dispose();
    super.dispose();
  }

  Color _getIconColor(FocusNode? focusNode) {
    return (focusNode?.hasFocus ?? false) ? _focusColor : _unfocusColor;
  }

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime initialDate = DateTime(2000);
    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd-MM-yyyy').parse(controller.text);
      } catch (_) {
        initialDate = DateTime(2000);
      }
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  bool _isImagePickerActive = false;
  Future<void> _pickImage() async {
    if (_isImagePickerActive) return;
    _isImagePickerActive = true;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _studentCardImage = File(picked.path);
      });
    }
    _isImagePickerActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                label: "Mã Sinh Viên",
                controller: _studentCodeController,
                focusNode: _studentCodeFocusNode,
                icon: Icons.badge,
              ),
              _buildTextField(
                label: "Email Học Sinh",
                controller: _studentEmailController,
                focusNode: _studentEmailFocusNode,
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập Email Học Sinh';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Tên Trường Học",
                controller: _schoolController,
                focusNode: _schoolFocusNode,
                icon: Icons.school,
              ),
              _buildTextField(
                label: "Họ",
                controller: _firstNameController,
                focusNode: _firstNameFocusNode,
                icon: Icons.person,
              ),
              _buildTextField(
                label: "Tên",
                controller: _lastNameController,
                focusNode: _lastNameFocusNode,
                icon: Icons.person,
              ),
              _buildDateField(
                "Ngày Sinh",
                _dobController,
                focusNode: FocusNode(),
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ảnh Thẻ Sinh Viên *",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildImagePicker(),
              const SizedBox(height: 24),
              SubmitButton(
                formKey: _formKey,
                onSubmit: () {
                  if (_formKey.currentState!.validate() &&
                      _studentCardImage != null) {
                    try {
                      final dob = DateFormat(
                        'dd-MM-yyyy',
                      ).parse(_dobController.text);

                      context.read<VerificationCubit>().submitVerification(
                        studentCode: _studentCodeController.text,
                        schoolName: _schoolController.text,
                        studentEmail: _studentEmailController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        // fullName: _fullNameController.text,
                        dateOfBirth: dob,
                        studentCardImage: _studentCardImage!,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ngày sinh không hợp lệ')),
                      );
                    }
                  } else if (_studentCardImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Upload student card image'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    FocusNode? focusNode,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: "$label *",
          labelStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: (focusNode?.hasFocus ?? false) ? _focusColor : _unfocusColor,
          ),
          prefixIcon:
              icon != null ? Icon(icon, color: _getIconColor(focusNode)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _unfocusColor, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _focusColor, width: 2.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _unfocusColor, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
        validator:
            validator ??
            (value) =>
                value == null || value.isEmpty ? 'Please input $label' : null,
      ),
    );
  }

  Widget _buildDateField(
    String label,
    TextEditingController controller, {
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: true,
        onTap: () => _pickDate(controller),
        decoration: InputDecoration(
          labelText: "$label *",
          labelStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: (focusNode?.hasFocus ?? false) ? _focusColor : _unfocusColor,
          ),
          prefixIcon: Icon(
            Icons.calendar_today,
            color: _getIconColor(focusNode),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _unfocusColor, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _focusColor, width: 2.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: _unfocusColor, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Please choose $label' : null,
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          border: Border.all(
            color: _studentCardImage == null ? _unfocusColor : _focusColor,
            width: _studentCardImage == null ? 1.5 : 2.5,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child:
            _studentCardImage == null
                ? const Center(
                  child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _studentCardImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
      ),
    );
  }
}
