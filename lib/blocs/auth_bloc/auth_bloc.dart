import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/auth_model/auth_model.dart';
import 'package:bpbm2/data/models/auth_model/user_model.dart';
import 'package:bpbm2/data/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial(isLoading: false)) {
    on<AuthEvent>((event, emit) async {
      await authRepository.loadInfo();
      String cellNumber = '';
      Future<String> loadCellNumber() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        cellNumber = prefs.getString('cellNumber') ?? '';
        return cellNumber;
      }

      Future<UserModel> loadUser() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.reload();
        final int userId = prefs.getInt('userId') ?? 0;
        final String cellNumber = prefs.getString('cellNumber') ?? '';
        final user = UserModel(
          id: userId,
          cellNumber: cellNumber,
        );
        return user;
      }

      if (event is AuthStarted) {
        if (AuthRepository.authChangeNotifier.value == null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          emit(const AuthInitial(isLoading: false));
        } else {
          final user = await loadUser();
          emit(AuthSuccess(user: user));
        }
      }

      if (event is AuthSendSms) {
        emit(const AuthInitial(isLoading: true));
        await authRepository
            .sendSms(cellNumber: event.cellNumber)
            .then((response) {
          emit(const SendSmsSuccess(isLoading: false));
        }).catchError((e) {
          emit(const AuthInitial(isLoading: false));
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is AuthVerifySms) {
        emit(const SendSmsSuccess(isLoading: true));
        await loadCellNumber();
        await authRepository
            .verifySms(
          cellNumber: cellNumber,
          otpCode: event.otpCode,
        )
            .then((response) {
          emit(
            VerifySmsSuccess(
              isLoading: false,
              authModel: response,
            ),
          );
        }).catchError((e) {
          emit(const SendSmsSuccess(isLoading: false));
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is AuthSignOut) {
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        await authRepository.signOut().then((response) {
          emit(const AuthInitial(isLoading: false));
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }
    });
  }
}
