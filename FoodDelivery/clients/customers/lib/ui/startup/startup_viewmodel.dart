import 'package:customers/app/app.locator.dart';
import 'package:customers/app/app.logger.dart';
import 'package:customers/app/app.router.dart';
import 'package:customers/constants/app_keys.dart';
import 'package:customers/services/environment_service.dart';
import 'package:customers/services/user_service.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// ignore: depend_on_referenced_packages

class StartUpViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _environmentService = locator<EnvironmentService>();
  final _placesService = locator<PlacesService>();

  Future<void> runStartupLogic() async {
    await _environmentService.initialise();

    _placesService.initialize(apiKey: _environmentService.getValue(GoogleMapsEnvKey));

    if (_userService.hasLoggedInUser) {
      log.v('We have a user session on disk. Sync the user profile ...');
      await _userService.syncUserAccount();

      final currentUser = _userService.currentUser;
      log.v('User sync complete. User profile: $currentUser');

      if (!currentUser.hasAddress) {
        _navigationService.navigateTo(Routes.addressSelectionView);
      } else {
        log.v('We have a default address. Let\'s show them products!');
        _navigationService.replaceWith(Routes.homeView);
        // navigate to home view
      }
    } else {
      log.v('No user on disk, navigate to the LoginView');
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
