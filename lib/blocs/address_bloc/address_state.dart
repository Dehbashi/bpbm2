part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

class CurrentAddressSuccess extends AddressState {
  final List<AddressModel> addresses;
  final int transportationCost;
  final bool currentAddressScreen;

  const CurrentAddressSuccess({
    required this.addresses,
    required this.transportationCost,
    required this.currentAddressScreen,
  });

  @override
  List<Object> get props => [addresses, transportationCost, currentAddressScreen];
}

class CurrentAddressEmpty extends AddressState {
  final String message;

  const CurrentAddressEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class NewAddressSuccess extends AddressState {
  final int transportationCost;
  final bool currentAddressScreen;

  const NewAddressSuccess({
    required this.transportationCost,
    required this.currentAddressScreen,
  });

  @override
  List<Object> get props => [transportationCost, currentAddressScreen];
}
