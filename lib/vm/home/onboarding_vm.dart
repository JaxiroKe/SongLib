import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

import '../../repository/local_storage.dart';
import '../../util/constants/pref_constants.dart';

@injectable
class OnboardingVm with ChangeNotifierEx {
  late final OnboardingNavigator navigator;
  final LocalStorage localStorage;

  OnboardingVm(this.localStorage);

  Future<void> init(OnboardingNavigator screenNavigator) async {
    navigator = screenNavigator;
  }

  Future<void> finishOnboarding() async {
    localStorage.setPrefBool(PrefConstants.onboardedCheckKey, true);
    navigator.goToHome();
  }
}

abstract class OnboardingNavigator {
  void goToHome();
}
