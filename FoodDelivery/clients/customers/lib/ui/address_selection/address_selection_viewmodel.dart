import 'package:customers/api/firestore_api.dart';
import 'package:customers/app/app.locator.dart';
import 'package:customers/app/app.logger.dart';
import 'package:customers/app/app.router.dart';
import 'package:customers/constants/app_strings.dart';
import 'package:customers/enums/basic_dialog_status.dart';
import 'package:customers/enums/dialog_type.dart';
import 'package:customers/models/application_models.dart';
import 'package:customers/services/user_service.dart';
import 'package:stacked/stacked.dart';
// ignore: depend_on_referenced_packages
import 'package:places_service/places_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:customers/extensions/string_extensions.dart';

import 'address_selection_view.form.dart';

class AddressSelectionViewModel extends FormViewModel {
  final log = getLogger('AddressSelectionViewModel');

  final _placesService = locator<PlacesService>();
  final _dialogService = locator<DialogService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  List<PlacesAutoCompleteResult> _autoCompleteResults = [];
  PlacesAutoCompleteResult? _selectedResult;

  bool get hasSelectedPlace => _selectedResult != null;

  List<PlacesAutoCompleteResult> get autoCompleteResults =>
      _autoCompleteResults;

  bool get hasAutoCompleteResults => _autoCompleteResults.isNotEmpty;

  /// Indicated whether the [BoxInputField] is focused or not
  /// We can use this property for animation to move the "search input" higher when the user focus's on it
  bool focus = false;

  @override
  void setFormStatus() {
    _getAutoCompleteResults();
  }

  Future<void> _getAutoCompleteResults() async {
    if (addressValue != null) {
      final List<PlacesAutoCompleteResult> placesResults = await _placesService.getAutoComplete(addressValue!);

      _autoCompleteResults = placesResults;
      notifyListeners();
    }
  }

  /// Gets the details from the Places Api and saves it to the backend
  Future<void> selectAddressSuggestion({
    PlacesAutoCompleteResult? autoCompleteResult,
  }) async {
    PlacesAutoCompleteResult selectedResult =
        autoCompleteResult ?? _selectedResult!;

    log.i('Selected $selectedResult as the suggestion');

    if (selectedResult.placeId == null) {
      _dialogService.showDialog(
        title: InvalidAutoCompleteDialogTitle,
        description: InvalidAutoCompleteDialogDescription,
      );
    } else {
      setBusy(true);

      final placeDetails =
          await _placesService.getPlaceDetails(selectedResult.placeId ?? '');
      log.v('Place Details: $placeDetails');

      final city = placeDetails.city ?? '';

      final cityServiced =
          await _firestoreApi.isCityServiced(city: city.toCityDocument);

      if (!cityServiced) {
        await _dialogService.showCustomDialog(
          variant: DialogType.basic,
          data: BasicDialogStatus.error,
          title: CityNotServicedDialogTitle,
          description: CityNotServicedDialogDescripton,
          mainButtonTitle: CityNotServicedDialogMainButton,
          secondaryButtonTitle: CityNotServicedDialogSecondaryButton,
        );
      } else {
        final address = Address(
          placeId: placeDetails.placeId!,
          lattitude: placeDetails.lat ?? -1,
          longitute: placeDetails.lng ?? -1,
          city: placeDetails.city,
          postalCode: placeDetails.zip,
          state: placeDetails.state,
          street: placeDetails.streetLong ?? placeDetails.streetShort,
        );

        final saveSuccess = await _firestoreApi.saveAddress(
          address: address,
          user: _userService.currentUser,
        );

        if (!saveSuccess) {
          log.v('Address save failed. Notify user to try again.');
          _dialogService.showDialog(
            title: AddressSaveFailedDialogTitle,
            description: AddressSaveFailedDialogDescription,
          );
        } else {
          log.v(
              'Address has been saved! We\'re ready to show them some products!');
          _navigationService.clearStackAndShow(Routes.homeView);
        }
      }

      setBusy(false);
    }
  }

  void setSelectedSuggestion(PlacesAutoCompleteResult autoCompleteResult) {
    log.i('autoCompleteResult:$autoCompleteResult');
    _selectedResult = autoCompleteResult;

    _autoCompleteResults.clear();

    notifyListeners();
  }

  /// Updates the [BoxInputField] focus state
  void onFocusChanged(bool isFocus) {
    focus = isFocus;
    notifyListeners();
  }
}