part of 'service_list_bloc.dart';

sealed class ServiceListState extends Equatable {
  const ServiceListState();

  @override
  List<Object> get props => [];
}

final class ServiceListInitial extends ServiceListState {}

class ServiceListSuccessful extends ServiceListState {
  final List<ServiceListModel> serviceList;

  const ServiceListSuccessful({required this.serviceList});

  @override
  List<Object> get props => [serviceList];
}

class ServiceListFailed extends ServiceListState {}
