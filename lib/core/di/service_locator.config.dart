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
import 'package:metro_ticketing_system_mobile/features/student_verification/data/student_verification_repository.dart'
as _i1020;
import 'package:metro_ticketing_system_mobile/features/student_verification/data/student_verification_service.dart'
as _i1009;
import 'package:metro_ticketing_system_mobile/features/student_verification/logic/verification_cubit.dart'
as _i101;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i689.SecureStorage>(() => _i689.SecureStorage());
    gh.lazySingleton<_i1037.AuthRepository>(() => _i1037.AuthRepository());
    gh.lazySingleton<_i728.AuthService>(
      () => _i728.AuthService(gh<_i1037.AuthRepository>()),
    );
    gh.factory<_i413.RegisterCubit>(
      () => _i413.RegisterCubit(gh<_i728.AuthService>()),
    );
    gh.factory<_i18.LoginCubit>(
      () => _i18.LoginCubit(gh<_i728.AuthService>(), gh<_i689.SecureStorage>()),
    );
    gh.lazySingleton<_i1020.StudentVerificationRepository>(
          () => _i1020.StudentVerificationRepository(
          gh<_i689.SecureStorage>()
      ),
    );
    gh.lazySingleton<_i1009.StudentVerificationService>(
          () => _i1009.StudentVerificationService(
        gh<_i1020.StudentVerificationRepository>(),
      ),
    );
    gh.factory<_i101.VerificationCubit>(
            () => _i101.VerificationCubit(
          gh<_i1009.StudentVerificationService>(),
        ),
    );
    return this;
  }
}
