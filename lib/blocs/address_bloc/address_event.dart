part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressStarted extends AddressEvent {
  final BuildContext context;

  const AddressStarted({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}

class NewAddressStarted extends AddressEvent {
  final BuildContext context;

  const NewAddressStarted({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}

class RegisterNewAddress extends AddressEvent {
  final BuildContext context;
  final double lat;
  final double lng;

  const RegisterNewAddress({
    required this.context,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [
        context,
        lat,
        lng,
      ];
}

class SaveNewAddress extends AddressEvent {
  final MapModel address;
  final String fullAddress;
  final String houseNumber;
  final String unitNumber;
  final double lat;
  final double lng;

  const SaveNewAddress({
    required this.address,
    required this.fullAddress,
    required this.houseNumber,
    required this.unitNumber,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [
        address,
        houseNumber,
        unitNumber,
      ];
}

class SelectPreviousAddress extends AddressEvent {
  final BuildContext context;

  const SelectPreviousAddress({required this.context});

  @override
  List<Object> get props => [context];
}

class EditCurrentAddress extends AddressEvent {
  final AddressModel address;
  final double lat;
  final double lng;

  const EditCurrentAddress({
    required this.address,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [address];
}

class EditAddressStarted extends AddressEvent {
  final AddressModel address;

  const EditAddressStarted({
    required this.address,
  });

  @override
  List<Object> get props => [address];
}

class CurrentAddressSelected extends AddressEvent {
  final BuildContext context;
  final AddressModel address;
  final List<AddressModel> addresses;

  const CurrentAddressSelected({
    required this.context,
    required this.address,
    required this.addresses,
  });

  @override
  List<Object> get props => [
        context,
        address,
        addresses,
      ];
}
