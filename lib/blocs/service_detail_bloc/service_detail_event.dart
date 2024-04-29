part of 'service_detail_bloc.dart';

sealed class ServiceDetailEvent extends Equatable {
  const ServiceDetailEvent();

  @override
  List<Object> get props => [];
}

class ServiceDetailStarted extends ServiceDetailEvent {
  final int serviceId;
  final BuildContext context;

  const ServiceDetailStarted({
    required this.serviceId,
    required this.context,
  });

  @override
  List<Object> get props => [serviceId, context];
}
