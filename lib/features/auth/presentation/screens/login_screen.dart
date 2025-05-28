import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart';
import '../../../../core/di/service_locator.dart';
import '../../logic/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {


  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (_) => LoginCubit(getIt<AuthService>()),
        child: const LoginForm(),
      ),
    );
  }
}
