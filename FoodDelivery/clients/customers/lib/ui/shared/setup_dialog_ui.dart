import 'package:customers/app/app.locator.dart';
import 'package:customers/enums/dialog_type.dart';
import 'package:customers/ui/shared/dialog/basic_dialog.dart';
// ignore: depend_on_referenced_packages
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, dialogRequest, dialogResponse) =>
        BasicCustomDialog(
          dialogRequest: dialogRequest,
          onDialogTap: dialogResponse,
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
