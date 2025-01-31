import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:songlib/common/utils/api_util.dart';

import 'common/auth/auth_bloc.dart';
import 'common/repository/sync_repository.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'core/theme/theme_data.dart';
import 'common/utils/constants/pref_constants.dart';
import 'common/utils/date_util.dart';
import 'common/repository/auth_repository.dart';
import 'common/repository/pref_repository.dart';
import 'core/di/injectable.dart';
import 'core/navigator/main_navigator.dart';
import 'core/navigator/route_names.dart';

class MyApp extends StatefulWidget {
  final Widget? home;
  const MyApp({super.key, this.home});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;
  late final AuthRepository _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepository();
  }

  @override
  void dispose() {
    _authRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepo: _authRepo),
        child: const AppView(),
      ),
    );
  }
}

/// A widget that builds the main view of the application. It sets up the
/// necessary providers and handles navigation and theming.
///
/// The [AppView] widget can optionally take a [home] widget to display as the
/// initial screen.
class AppView extends StatefulWidget {
  final Widget? home;
  const AppView({super.key, this.home});

  @override
  State<AppView> createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;
  final _syncRepo = SyncRepository();
  final _prefrepo = getIt<PrefRepository>();

  @override
  Widget build(BuildContext context) {
    bool isSelected = _prefrepo.getPrefBool(PrefConstants.dataIsSelectedKey);
    bool isLoaded = _prefrepo.getPrefBool(PrefConstants.dataIsLoadedKey);

    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            home: widget.home,
            themeMode: _prefrepo.getThemeMode(),
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            supportedLocales: const [Locale('en'), Locale('sw')],
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: MainNavigatorState.initialRoute,
            onGenerateRoute: MainNavigatorState.onGenerateRoute,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (isLoaded) {
                  if (await isConnectedToInternet()) {
                    await _syncRepo.syncData();
                  }
                  navigator.pushNamedAndRemoveUntil<void>(
                    RouteNames.home,
                    (route) => false,
                  );
                } else {
                  if (isSelected) {
                    navigator.pushNamedAndRemoveUntil<void>(
                      RouteNames.step2Selection,
                      (route) => false,
                    );
                  } else {
                    _prefrepo.setPrefString(
                      PrefConstants.dateInstalledKey,
                      dateNow(),
                    );
                    navigator.pushNamedAndRemoveUntil<void>(
                      RouteNames.step1Selection,
                      (route) => false,
                    );
                  }
                }
              },
              child: child,
            ),
          );
        },
      ),
    );
  }
}
