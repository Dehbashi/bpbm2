part of 'service_list_bloc.dart';

sealed class ServiceListEvent extends Equatable {
  const ServiceListEvent();

  @override
  List<Object> get props => [];
}

class ServiceListStarted extends ServiceListEvent {
  final BuildContext context;

  const ServiceListStarted({required this.context});

  @override
  List<Object> get props => [context];
}
