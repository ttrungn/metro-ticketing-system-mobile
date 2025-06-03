import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/text_input_field.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/register_button.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/login_google_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final Color _focusColor = ConstantAppColor.primary;
  final Color _unfocusColor = Colors.grey[400]!;

  // Error messages for each field
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.addListener(() {
      if (!_firstNameFocusNode.hasFocus) {
        _validateFirstName();
      } else {
        setState(() {
          _firstNameError = null;
        });
      }
    });

    _lastNameFocusNode.addListener(() {
      if (!_lastNameFocusNode.hasFocus) {
        _validateLastName();
      } else {
        setState(() {
          _lastNameError = null;
        });
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _validateEmail();
      } else {
        setState(() {
          _emailError = null;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _validatePassword();
      } else {
        setState(() {
          _passwordError = null;
        });
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        _validateConfirmPassword();
      } else {
        setState(() {
          _confirmPasswordError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validation methods for each field (simplified - no focus checks needed)
  void _validateFirstName() {
    setState(() {
      if (_firstNameController.text.isEmpty) {
        _firstNameError = 'First name is required';
      } else if (_firstNameController.text.length < 2) {
        _firstNameError = 'First name must be at least 2 characters';
      } else {
        _firstNameError = null;
      }
    });
  }

  void _validateLastName() {
    setState(() {
      if (_lastNameController.text.isEmpty) {
        _lastNameError = 'Last name is required';
      } else if (_lastNameController.text.length < 2) {
        _lastNameError = 'Last name must be at least 2 characters';
      } else {
        _lastNameError = null;
      }
    });
  }

  void _validateEmail() {
    setState(() {
      final email = _emailController.text;
      if (email.isEmpty) {
        _emailError = 'Email is required';
      } else if (!_isValidEmail(email)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      final password = _passwordController.text;
      if (password.isEmpty) {
        _passwordError = 'Password is required';
      } else if (password.length < 5 || password.length > 12) {
        _passwordError = 'Password must be 5-12 characters long';
      } else if (!RegExp(r'[a-z]').hasMatch(password)) {
        _passwordError = 'Password must contain at least 1 lowercase letter';
      } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
        _passwordError = 'Password must contain at least 1 uppercase letter';
      } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
        _passwordError = 'Password must contain at least 1 special character';
      } else {
        _passwordError = null;
      }
    });
  }

  void _validateConfirmPassword() {
    setState(() {
      final confirmPassword = _confirmPasswordController.text;
      if (confirmPassword.isEmpty) {
        _confirmPasswordError = 'Please confirm your password';
      } else if (confirmPassword != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Widget _buildFirstNameField() {
    return TextInputField(
      controller: _firstNameController,
      focusNode: _firstNameFocusNode,
      icon: Icons.person,
      labelText: 'Tên',
      prefixIcon: Icons.person,
      errorText: _firstNameError,
      focusColor: _focusColor,
      unfocusColor: _unfocusColor,
    );
  }

  Widget _buildLastNameField() {
    return TextInputField(
      controller: _lastNameController,
      focusNode: _lastNameFocusNode,
      icon: Icons.person,
      labelText: 'Họ',
      prefixIcon: Icons.person,
      errorText: _lastNameError,
      focusColor: _focusColor,
      unfocusColor: _unfocusColor,
    );
  }

  Widget _buildEmailField() {
    return TextInputField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      icon: Icons.email,
      labelText: 'Email',
      prefixIcon: Icons.email,
      errorText: _emailError,
      focusColor: _focusColor,
      unfocusColor: _unfocusColor,
    );
  }

  Widget _buildPasswordField() {
    return TextInputField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      icon: Icons.lock,
      labelText: 'Mật Khẩu',
      prefixIcon: Icons.lock,
      errorText: _passwordError,
      focusColor: _focusColor,
      unfocusColor: _unfocusColor,
      initialObscure: true,
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextInputField(
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      icon: Icons.lock,
      labelText: 'Xác Nhận Mật Khẩu',
      prefixIcon: Icons.lock,
      errorText: _confirmPasswordError,
      focusColor: _focusColor,
      unfocusColor: _unfocusColor,
      initialObscure: true,
    );
  }

  Widget _buildSeparator() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('HOẶC', style: TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
      ],
    );
  }

  Widget _buildLoginNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bạn đã có tài khoản? ",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Đăng nhập',
            style: TextStyle(
              color: ConstantAppColor.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  bool _validateAllFields() {
    _validateFirstName();
    _validateLastName();
    _validateEmail();
    _validatePassword();
    _validateConfirmPassword();
    return _firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/icon/metro_logo_nobg.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFirstNameField(),
                  const SizedBox(height: 24),
                  _buildLastNameField(),
                  const SizedBox(height: 24),
                  _buildEmailField(),
                  const SizedBox(height: 24),
                  _buildPasswordField(),
                  const SizedBox(height: 24),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 32),
                  RegisterButton(
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onValidationRequired: _validateAllFields,
                  ),
                  const SizedBox(height: 24),
                  _buildSeparator(),
                  const SizedBox(height: 24),
                  LoginGoogleButton(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildLoginNavigationButton(),
          ],
        ),
      ),
    );
  }
}
