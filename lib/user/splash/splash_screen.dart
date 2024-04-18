import 'package:flutter/material.dart';

import '../../common/theme/theme_colors.dart';
import '../../common/utils/constants/app_assets.dart';
import '../../common/utils/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var withLoveFromRow = const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'with ',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            color: ThemeColors.primary,
          ),
        ),
        Icon(
          Icons.favorite_rounded,
          color: ThemeColors.primaryDark,
        ),
        Text(
          ' from',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            color: ThemeColors.primary,
          ),
        ),
      ],
    );

    var appDevelopers = const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Names app developers in splash screen
        Text(
          AppConstants.appCredits1,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeColors.primaryDark,
          ),
        ),
        Text(
          ' & ',
          style: TextStyle(
            fontSize: 20,
            color: ThemeColors.primary,
          ),
        ),
        Text(
          AppConstants.appCredits2,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeColors.primaryDark,
          ),
        ),
      ],
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            // Shows app icon on splash screen
            Image.asset(AppAssets.appIcon, height: 200, width: 200),
            const SizedBox(height: 10),
            const Text(
              AppConstants.appTitle,
              style: TextStyle(
                fontSize: 50,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                color: ThemeColors.primary,
              ),
            ),
            const SizedBox(height: 5),
            // Shows app version on splash screen
            const Text(
              AppConstants.appVersion,
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                color: ThemeColors.primaryDark,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Divider(
                  color: ThemeColors.primaryDark, thickness: 2, height: 50),
            ),
            withLoveFromRow,
            appDevelopers,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
