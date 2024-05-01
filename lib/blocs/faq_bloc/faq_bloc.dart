import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/faq_list/faq_model.dart';
import 'package:bpbm2/data/repo/fetch_faq_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqInitial()) {
    on<FaqEvent>((event, emit) async {
      if (event is FaqStarted) {
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        try {
          final faqs = await fetchFaqRepository.fetchFaqs();
          emit(FaqSuccess(faqs: faqs));
          LoadingScreen.instance().hide();
        } catch (e) {
          LoadingScreen.instance().hide();
          emit(FaqFailed());
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        }
      }
    });
  }
}
