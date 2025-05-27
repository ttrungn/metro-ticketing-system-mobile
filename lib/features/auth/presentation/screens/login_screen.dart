import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_repository.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import '../../logic/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  late final AuthRepository _authRepository;
  late final AuthService authService;

  LoginScreen({super.key}) {
    _authRepository = AuthRepository();
    authService = AuthService(_authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (_) => LoginCubit(authService),
        child: const LoginForm(),
      ),
    );
  }
}
