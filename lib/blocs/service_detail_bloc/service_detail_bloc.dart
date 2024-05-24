import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/data/repo/fetch_service_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'service_detail_event.dart';
part 'service_detail_state.dart';

class ServiceDetailBloc extends Bloc<ServiceDetailEvent, ServiceDetailState> {
  ServiceDetailBloc() : super(ServiceDetailInitial()) {
    on<ServiceDetailEvent>((event, emit) {
      if (event is ServiceDetailStarted) {
        emit(ServiceDetailLoading());
        try {
          final serviceDetail = fetchServiceDetailRepository.fetchServiceDetail(
            serviceId: event.serviceId,
          );

          emit(
            ServiceDetailSuccess(
              serviceDetail: serviceDetail,
            ),
          );
        } catch (e) {
          emit(ServiceDetailFailed());
          print(e.toString());
          customErrorMessenger(
            context: event.context,
            message: 'خطای نامشخص',
          );
        }
      }
    });
  }
}
