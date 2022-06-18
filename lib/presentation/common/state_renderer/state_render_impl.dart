import 'package:flutter/material.dart';
import 'package:not_so_secret/data/mapper/mapper.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_renderer.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}
//Loading State(POPUP,FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading.tr();

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error State (POPUP,FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//Content State
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

// empty State
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            //showing popup dialog
            //return the content ui of the screen
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          } //StateRendererType.FULL_SCREEN_LOADING_STATE
        }
      case ErrorState:
        {
          dissmisDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            //showing popup dialog
            //return the content ui of the screen
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            {
              return StateRenderer(
                  stateRendererType: getStateRendererType(),
                  message: getMessage(),
                  retryActionFunction: retryActionFunction);
            } //StateRendererType.FULL_ERROR_LOADING_STATE}
          }
        }
      case ContentState:
        {
          dissmisDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dissmisDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: () {},
            )));
  }
}
