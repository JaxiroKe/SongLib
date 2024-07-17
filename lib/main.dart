import 'package:flutter/material.dart';

import 'app_main_window.dart';
import 'common/utils/env/flavor_config.dart';
import 'common/utils/logger.dart';
import 'common/utils/env/environments.dart';
import 'di/injectable.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: Flavor.dev,
    name: 'DEV',
    color: Colors.red,
    values: const FlavorValues(
      logNetworkInfo: true,
      showFullErrorMessages: true,
    ),
  );
  logger('Starting app from main.dart');
  await configureDependencies(Environments.dev);

  runApp(const AppMainWindow());
}
