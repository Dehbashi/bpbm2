part of 'final_order_bloc.dart';

sealed class FinalOrderState extends Equatable {
  const FinalOrderState();

  @override
  List<Object> get props => [];
}

final class FinalOrderInitial extends FinalOrderState {}

class FinalOrderSuccess extends FinalOrderState {
  final List<QuestionModel> products;
  final double priceOfProducts;
  final List<QuestionModel> services;
  final double priceOfServices;
  final String discount;
  final double totalPrice;
  final AddressModel address;

  const FinalOrderSuccess({
    required this.products,
    required this.priceOfProducts,
    required this.services,
    required this.priceOfServices,
    required this.discount,
    required this.totalPrice,
    required this.address,
  });

  @override
  List<Object> get props => [
        products,
        priceOfProducts,
        services,
        priceOfServices,
        discount,
        totalPrice,
        address,
      ];
}

class FinalOrderFailed extends FinalOrderState {}
