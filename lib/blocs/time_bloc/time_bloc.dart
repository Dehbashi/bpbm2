import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/time_model/time_model.dart';
import 'package:bpbm2/data/repo/time_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  final BuildContext context;
  TimeBloc(this.context) : super(TimeInitial()) {
    List<TimeModel> dates = [];
    TimeModel pickedDate = const TimeModel(
      id: 0,
      title: 'title',
      text: 'text',
    );
    bool morningSelected = true;
    on<TimeEvent>((event, emit) async {
      if (event is TimeStarted) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await timeRepository.fetchTime().then((response) {
          dates = response;
          pickedDate = dates.first;
          emit(
            TimeSuccess(
              dates: dates,
              pickedDate: pickedDate,
              morningSelected: morningSelected,
            ),
          );
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          emit(TimeFailed());
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is DateChanged) {
        pickedDate = event.pickedDate;
        emit(
          TimeSuccess(
            dates: dates,
            pickedDate: pickedDate,
            morningSelected: morningSelected,
          ),
        );
      }

      if (event is TimeChanged) {
        morningSelected = morningSelected ? false : true;
        emit(
          TimeSuccess(
            dates: dates,
            pickedDate: pickedDate,
            morningSelected: morningSelected,
          ),
        );
      }

      if (event is TimeSaved) {
        await saveTimeAndDate(
          date: event.pickedDate,
          time: event.pickedTime,
        );
      }
    });
  }
  Future<void> saveTimeAndDate({
    required TimeModel date,
    required String time,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final day = date.title;
    final exactDate = date.text;
    prefs.setString('selectedDate', jsonEncode(date.toJson()));
    prefs.setString('selectedTime', time);
    // prefs.setString('selectedDate', '$day $exactDate $time');

    // final selectedDate = prefs.getString('selectedDate');
  }
}
