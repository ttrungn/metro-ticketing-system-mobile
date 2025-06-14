import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/login_button.dart';
import 'package:metro_ticketing_system_mobile/features/auth/presentation/widgets/login_google_button.dart';

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

  final Color _focusColor = ConstantAppColor.primary;
  final Color _unfocusColor = Colors.grey[400]!;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Color _getIconColor(FocusNode node) =>
      node.hasFocus ? _focusColor : _unfocusColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icon/metro_logo_nobg.png',
              height: MediaQuery.of(context).size.height * 0.35), // or whatever height works
            ),
          TextField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: _emailFocusNode.hasFocus ? _focusColor : _unfocusColor,
              ),
              prefixIcon: Icon(
                Icons.email,
                color: _getIconColor(_emailFocusNode),
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
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color:
                    _passwordFocusNode.hasFocus ? _focusColor : _unfocusColor,
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: _getIconColor(_passwordFocusNode),
              ),
              suffixIcon: Tooltip(
                message: _obscureText ? 'Show password' : 'Hide password',
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _getIconColor(_passwordFocusNode),
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
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
            ),
          ),
          const SizedBox(height: 32),
          LoginButton(
            email: _emailController.text,
            password: _passwordController.text,
          ),
          const SizedBox(height: 24),
          // Separator line
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('OR', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
            ],
          ),
          const SizedBox(height: 24),
          // Login with Google button
          LoginGoogleButton(),
        ],
      ),
    );
  }
}
