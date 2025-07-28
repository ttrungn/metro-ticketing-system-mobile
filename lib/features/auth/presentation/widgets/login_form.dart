import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/text_input_field.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/login_button.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/screens/register_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? _emailError;
  String? _passwordError;

  final Color _focusColor = ConstantAppColor.primary;
  final Color _unfocusColor = Colors.grey[400]!;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
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
      } else {
        _passwordError = null;
      }
    });
  }

  bool _validateAllFields() {
    _validateEmail();
    _validatePassword();

    return _emailError == null && _passwordError == null;
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

  Widget _buildRegisterNavigationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bạn chưa có tài khoản? ",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: Text(
            'Đăng ký',
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                _buildEmailField(),
                const SizedBox(height: 32),
                _buildPasswordField(),
                const SizedBox(height: 32),
                LoginButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onValidationRequired: _validateAllFields,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildRegisterNavigationButton(),
        ],
      ),
    );
  }
}
