part of 'service_detail_bloc.dart';

sealed class ServiceDetailState extends Equatable {
  const ServiceDetailState();

  @override
  List<Object> get props => [];
}

final class ServiceDetailInitial extends ServiceDetailState {}

class ServiceDetailSuccess extends ServiceDetailState {
  final ServiceDetailModel serviceDetail;

  const ServiceDetailSuccess({
    required this.serviceDetail,
  });

  @override
  List<Object> get props => [
        serviceDetail,
      ];
}

class ServiceDetailFailed extends ServiceDetailState {}

class ServiceDetailLoading extends ServiceDetailState {}
