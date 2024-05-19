part of 'final_order_bloc.dart';

sealed class FinalOrderState extends Equatable {
  const FinalOrderState();

  @override
  List<Object> get props => [];
}

final class FinalOrderInitial extends FinalOrderState {}

class FinalOrderSuccess extends FinalOrderState {
  final List<QuestionModel> products;
  final int priceOfProducts;
  final List<QuestionModel> services;
  final int priceOfServices;
  final String discount;
  final int totalPrice;
  final int transportationCost;
  final AddressModel address;
  final List<UserInputModel> userInputs;
  final bool isDiscountLoading;

  const FinalOrderSuccess({
    required this.products,
    required this.priceOfProducts,
    required this.services,
    required this.priceOfServices,
    required this.discount,
    required this.totalPrice,
    required this.transportationCost,
    required this.address,
    required this.userInputs,
    required this.isDiscountLoading,
  });

  @override
  List<Object> get props => [
        products,
        priceOfProducts,
        services,
        priceOfServices,
        discount,
        totalPrice,
        transportationCost,
        address,
        userInputs,
        isDiscountLoading,
      ];
}

class FinalOrderFailed extends FinalOrderState {}

class FinalStep extends FinalOrderState {
  final int orderId;

  const FinalStep({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
