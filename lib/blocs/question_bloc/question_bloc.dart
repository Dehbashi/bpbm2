import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/question_model/question_service.dart';
import 'package:bpbm2/data/repo/question_repository.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial()) {
    on<QuestionEvent>((event, emit) async {
      if (event is QuestionStarted) {
        final provider =
            Provider.of<PriceProvider>(event.context, listen: false);
        provider.clearPrice();
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        await questionRepository
            .fetchFirstQuestion(id: event.serviceId)
            .then((questionService) {
          emit(QuestionSuccess(questionService: questionService));
          LoadingScreen.instance().hide();
        }).catchError((e) {
          emit(QuestionFailed());
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        });
      }

      if (event is NextQuestionRequest) {
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        if (event.nextRelation != 0) {
          await questionRepository
              .fetchNextQuestion(
            relationId: event.nextRelation,
            serviceId: event.serviceId,
          )
              .then((questionService) {
            LoadingScreen.instance().hide();
            emit(QuestionSuccess(questionService: questionService));
          }).catchError((e) {
            LoadingScreen.instance().hide();
            emit(QuestionFailed());
            customErrorMessenger(
              context: event.context,
              message: 'خطای نامشخص',
            );
          });
        } else {
          LoadingScreen.instance().hide();
          emit(QuestionFinish());
        }
      }
    });
  }
}
