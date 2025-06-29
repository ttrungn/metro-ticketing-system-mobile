// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:metro_ticketing_system_mobile/core/storage/secure_storage.dart'
    as _i689;
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_repository.dart'
    as _i1037;
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart'
    as _i728;
import 'package:metro_ticketing_system_mobile/features/auth/logic/login_cubit.dart'
    as _i18;
import 'package:metro_ticketing_system_mobile/features/auth/logic/register_cubit.dart'
    as _i413;
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/buy_ticket_repository.dart'
    as _i992;
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/buy_ticket_service.dart'
    as _i409;
import 'package:metro_ticketing_system_mobile/features/user/data/user_repository.dart'
    as _i431;
import 'package:metro_ticketing_system_mobile/features/user/data/user_service.dart'
    as _i785;
import 'package:metro_ticketing_system_mobile/features/user/logic/user_cubit.dart'
    as _i687;
import 'package:metro_ticketing_system_mobile/features/view_ticket/data/view_ticket_repository.dart'
    as _i982;

import '../../features/feedback/logic/feedback_cubit.dart' as _i882;
import '../../features/feedback/logic/feedback_type_cubit.dart' as _i511;
import '../../features/student_verification/data/student_verification_repository.dart' as _i1020;
import '../../features/student_verification/data/student_verification_repository.dart' as _i556;
import '../../features/student_verification/data/student_verification_service.dart' as _i15;
import '../../features/student_verification/logic/verification_cubit.dart' as _i101;
import '../../features/student_verification/logic/verification_cubit.dart' as _i157;
import '../../features/cart/data/cart_repository.dart' as _iCartRepo;
import '../../features/cart/data/cart_service.dart' as _iCartService;
import '../../features/cart/logic/cart_cubit.dart' as _iCartCubit;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i689.SecureStorage>(() => _i689.SecureStorage());
    gh.lazySingleton<_i1037.AuthRepository>(() => _i1037.AuthRepository());
    gh.lazySingleton<_i992.BuyTicketRepository>(
      () => _i992.BuyTicketRepository(),
    );
    gh.lazySingleton<_i1020.StudentVerificationRepository>(
      () => _i556.StudentVerificationRepository(),
    );
    gh.lazySingleton<_i431.UserRepository>(() => _i431.UserRepository());
    gh.lazySingleton<_i982.ViewTicketRepository>(
      () => _i982.ViewTicketRepository(),
    );
    gh.lazySingleton<_iCartRepo.CartRepository>(
      () => _iCartRepo.CartRepository(),
    );
    gh.lazySingleton<_i785.UserService>(
      () => _i785.UserService(gh<_i431.UserRepository>()),
    );
    gh.lazySingleton<_i409.BuyTicketService>(
      () => _i409.BuyTicketService(gh<_i992.BuyTicketRepository>()),
    );
    gh.lazySingleton<_i15.StudentVerificationService>(
      () => _i15.StudentVerificationService(
        gh<_i1020.StudentVerificationRepository>(),
      ),
    );
    gh.lazySingleton<_i728.AuthService>(
      () => _i728.AuthService(gh<_i1037.AuthRepository>()),
    );
    gh.lazySingleton<_iCartService.CartService>(
      () => _iCartService.CartService(gh<_iCartRepo.CartRepository>()),
    );
    gh.factory<_i882.FeedbackCubit>(
      () => _i882.FeedbackCubit(gh<_i785.UserService>()),
    );
    gh.factory<_i511.FeedbackTypeCubit>(
      () => _i511.FeedbackTypeCubit(gh<_i785.UserService>()),
    );
    gh.factory<_i687.UserCubit>(() => _i687.UserCubit(gh<_i785.UserService>()));
    gh.factory<_i101.VerificationCubit>(
      () => _i157.VerificationCubit(gh<_i15.StudentVerificationService>()),
    );
    gh.factory<_i413.RegisterCubit>(
      () => _i413.RegisterCubit(gh<_i728.AuthService>()),
    );
    gh.factory<_i18.LoginCubit>(
      () => _i18.LoginCubit(gh<_i728.AuthService>(), gh<_i689.SecureStorage>()),
    );
    gh.factory<_iCartCubit.CartCubit>(
      () => _iCartCubit.CartCubit(),
    );
    return this;
  }
}
