// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;
import 'package:songlib/common/home/bloc/home_bloc.dart' as _i7;
import 'package:songlib/data/db/app_database.dart' as _i3;
import 'package:songlib/data/repository/auth/auth_repository.dart' as _i5;
import 'package:songlib/data/repository/auth_repository.dart' as _i4;
import 'package:songlib/data/repository/database_repository.dart' as _i6;
import 'package:songlib/data/repository/local_storage.dart' as _i10;
import 'package:songlib/data/repository/pref/pref_repository.dart' as _i11;
import 'package:songlib/di/injectable.dart' as _i12;
import 'package:songlib/selection/selecting/bloc/selecting_bloc.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> initGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i3.AppDatabase>(
      () => registerModule.provideAppDatabase(),
      preResolve: true,
    );
    gh.lazySingleton<_i4.AuthRepository>(() => _i4.AuthRepository());
    gh.lazySingleton<_i5.AuthRepository>(() => _i5.AuthRepository());
    gh.lazySingleton<_i6.DatabaseRepository>(
        () => registerModule.provideDatabaseRepository(gh<_i3.AppDatabase>()));
    gh.factory<_i7.HomeBloc>(() => _i7.HomeBloc());
    gh.factory<_i8.SelectingBloc>(() => _i8.SelectingBloc());
    await gh.singletonAsync<_i9.SharedPreferences>(
      () => registerModule.localStorage(),
      preResolve: true,
    );
    gh.singleton<_i10.LocalStorage>(
        _i10.LocalStorage(gh<_i9.SharedPreferences>()));
    gh.lazySingleton<_i11.PrefRepository>(
        () => _i11.PrefRepository(gh<_i9.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
