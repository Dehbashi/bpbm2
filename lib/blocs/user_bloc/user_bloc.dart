import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BuildContext context;
  UserBloc(this.context) : super(const UserInitial(isLoading: false)) {
    String cellNumber = '';
    on<UserEvent>((event, emit) async {
      if (event is UserStarted) {
        emit(const UserInitial(isLoading: false));
      }

      if (event is SendSms) {
        emit(const UserInitial(isLoading: true));
        cellNumber = event.cellNumber;
        await authRepository.sendSms(cellNumber: cellNumber).then((response) {
          emit(UserSendSmsSuccess(
            isLoading: false,
            cellNumber: cellNumber,
          ));
        }).catchError((e) {
          emit(const UserInitial(isLoading: false));
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is SendOtp) {
        emit(UserSendSmsSuccess(
          isLoading: true,
          cellNumber: cellNumber,
        ));
        await authRepository
            .verifySms(
          cellNumber: cellNumber,
          otpCode: event.otpCode,
        )
            .then((response) {
          emit(const UserSendOtpSuccess(isLoading: false));
        }).catchError((e) {
          emit(UserSendSmsSuccess(
            isLoading: false,
            cellNumber: cellNumber,
          ));
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is ChangeCellNumber) {
        emit(const UserInitial(isLoading: false));
      }

      if (event is ResendSms) {
        emit(UserSendSmsSuccess(
          isLoading: true,
          cellNumber: cellNumber,
        ));
        await authRepository
            .sendSms(
          cellNumber: cellNumber,
        )
            .then((response) {
          emit(UserSendSmsSuccess(
            isLoading: false,
            cellNumber: cellNumber,
          ));
        }).catchError((e) {
          emit(UserSendSmsSuccess(
            isLoading: false,
            cellNumber: cellNumber,
          ));
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is RegisterName) {
        emit(const UserSendOtpSuccess(isLoading: true));
        await saveName(
          firstName: event.firstName,
          lastName: event.lastName,
        );
      }
    });
  }

  Future<void> saveName({
    required String firstName,
    required String lastName,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', firstName);
    prefs.setString('lastName', lastName);
  }
}
