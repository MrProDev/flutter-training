import 'package:customers/api/firestore_api.dart';
import 'package:customers/ui/home/home_view.dart';
import 'package:customers/services/environment_service.dart';
import 'package:customers/services/user_service.dart';
import 'package:customers/ui/address_selection/address_selection_view.dart';
import 'package:customers/ui/create_account/create_account_view.dart';
import 'package:customers/ui/login/login_view.dart';
import 'package:customers/ui/startup/startup_view.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AddressSelectionView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: EnvironmentService),
    LazySingleton(classType: PlacesService),
    LazySingleton(classType: FirestoreApi),
    Singleton(classType: FirebaseAuthenticationService),
  ],
  logger: StackedLogger()
)
class AppSetup {}
