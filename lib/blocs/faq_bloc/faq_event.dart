part of 'faq_bloc.dart';

sealed class FaqEvent extends Equatable {
  const FaqEvent();

  @override
  List<Object> get props => [];
}

class FaqStarted extends FaqEvent {
  final BuildContext context;

  const FaqStarted({required this.context});

  @override
  List<Object> get props => [context];
}
