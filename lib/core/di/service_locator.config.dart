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
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_repository.dart'
    as _i1037;
import 'package:metro_ticketing_system_mobile/features/auth/data/auth_service.dart'
    as _i728;
import 'package:metro_ticketing_system_mobile/features/auth/logic/login_cubit.dart'
    as _i18;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1037.AuthRepository>(() => _i1037.AuthRepository());
    gh.lazySingleton<_i728.AuthService>(() => _i728.AuthService(gh<_i1037.AuthRepository>()));
    gh.factory<_i18.LoginCubit>(() => _i18.LoginCubit(gh<_i728.AuthService>()));
    return this;
  }
}
