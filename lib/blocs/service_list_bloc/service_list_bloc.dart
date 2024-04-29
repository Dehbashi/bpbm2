import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:bpbm2/data/repo/fetch_service_list_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'service_list_event.dart';
part 'service_list_state.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {
  ServiceListBloc() : super(ServiceListInitial()) {
    on<ServiceListEvent>((event, emit) async {
      if (event is ServiceListStarted) {
        LoadingScreen.instance().show(
          context: event.context,
          text: 'در حال بارگذاری',
        );
        try {
          final serviceList =
              await fetchServiceListRepository.fetchServiceList();
          emit(ServiceListSuccessful(serviceList: serviceList));
          LoadingScreen.instance().hide();
        } catch (e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: event.context,
            message: 'تلاش ناموفق',
          );
          rethrow;
        }
      }
    });
  }
}
