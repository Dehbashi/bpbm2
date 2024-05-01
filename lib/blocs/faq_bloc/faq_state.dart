part of 'faq_bloc.dart';

sealed class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}

final class FaqInitial extends FaqState {}

class FaqSuccess extends FaqState {
  final List<FaqModel> faqs;

  const FaqSuccess({required this.faqs});

  @override
  List<Object> get props => [faqs];
}

class FaqFailed extends FaqState {}
