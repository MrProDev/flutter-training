import 'package:boxt_ui/box_ui.dart';
import 'package:customers/enums/basic_dialog_status.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BasicCustomDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;
  const BasicCustomDialog(
      {Key? key, required this.dialogRequest, required this.onDialogTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _BasicDialogContent(
          dialogRequest: dialogRequest, onDialogTap: onDialogTap),
    );
  }
}

class _BasicDialogContent extends StatelessWidget {
  const _BasicDialogContent(
      {Key? key, required this.dialogRequest, required this.onDialogTap})
      : super(key: key);

  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenHeightPercentage(context, percentage: 0.04),
          ),
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalSpaceSmall,
              BoxText.subheading(
                dialogRequest.title ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceSmall,
              BoxText.body(
                dialogRequest.description ?? '',
                align: TextAlign.center,
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dialogRequest.secondaryButtonTitle != null
                      ? TextButton(
                          onPressed: () =>
                              onDialogTap(DialogResponse(confirmed: false)),
                          child: BoxText.body(
                            dialogRequest.secondaryButtonTitle ?? '',
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox(),
                  TextButton(
                    onPressed: () =>
                        onDialogTap(DialogResponse(confirmed: true)),
                    child: BoxText.body(
                      dialogRequest.mainButtonTitle ?? '',
                      color: kcPrimaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -28,
          child: CircleAvatar(
            minRadius: 16,
            maxRadius: 28,
            backgroundColor: _getStatusColor(dialogRequest.data),
            child: Icon(
              _getStatusIcon(dialogRequest.data),
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(dynamic data) {
    switch (data) {
      case BasicDialogStatus.error:
        return kcRedColor;
      case BasicDialogStatus.warning:
        return kcOrangeColor;
      default:
        return kcPrimaryColor;
    }
  }

  IconData? _getStatusIcon(dynamic data) {
    switch (data) {
      case BasicDialogStatus.error:
        return Icons.close;
      case BasicDialogStatus.warning:
        return Icons.warning;
      default:
        return Icons.check;
    }
  }
}
