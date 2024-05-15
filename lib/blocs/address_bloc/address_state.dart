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
  final String? emptyMessage;
  final bool isFirstTime;

  const CurrentAddressSuccess({
    required this.addresses,
    required this.transportationCost,
    required this.currentAddressScreen,
    this.emptyMessage,
    required this.isFirstTime,
  });

  @override
  List<Object> get props =>
      [addresses, transportationCost, currentAddressScreen];
}

class NewAddressSuccess extends AddressState {
  final int transportationCost;
  final bool currentAddressScreen;
  final MapModel location;
  final double lat;
  final double lng;

  const NewAddressSuccess({
    required this.transportationCost,
    required this.currentAddressScreen,
    required this.location,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [
        transportationCost,
        currentAddressScreen,
        location,
        lat,
        lng,
      ];
}

class EditAddressSuccess extends AddressState {
  final AddressModel address;

  const EditAddressSuccess({required this.address});

  @override
  List<Object> get props => [address];
}
