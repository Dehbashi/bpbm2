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
  final String address;
  final String houseNumber;
  final String unit;

  const RegisterNewAddress({
    required this.context,
    required this.address,
    required this.houseNumber,
    required this.unit,
  });

  @override
  List<Object> get props => [
        context,
        address,
        houseNumber,
        unit,
      ];
}

class SelectPreviousAddress extends AddressEvent {
  final BuildContext context;

  const SelectPreviousAddress({required this.context});

  @override
  List<Object> get props => [context];
}

class EditCurrentAddress extends AddressEvent {
  final BuildContext context;
  final AddressModel address;

  const EditCurrentAddress({
    required this.context,
    required this.address,
  });

  @override
  List<Object> get props => [context, address];
}

class CurrentAddressSelected extends AddressEvent {
  final BuildContext context;
  final AddressModel address;
  final List<AddressModel> addresses;

  const CurrentAddressSelected(
      {required this.context, required this.address, required this.addresses});

  @override
  List<Object> get props => [
        context,
        address,
        addresses,
      ];
}
