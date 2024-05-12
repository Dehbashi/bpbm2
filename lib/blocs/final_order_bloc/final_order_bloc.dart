import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/question_model/user_input_model.dart';
import 'package:bpbm2/screens/stepper_screen/methods/load_order_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'final_order_event.dart';
part 'final_order_state.dart';

class FinalOrderBloc extends Bloc<FinalOrderEvent, FinalOrderState> {
  final BuildContext context;
  FinalOrderBloc(this.context) : super(FinalOrderInitial()) {
    on<FinalOrderEvent>((event, emit) async {
      if (event is FinalOrderStarted) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await fetchFinalOrderData().then((order) {
          final address = order.selectedAddress;
          final questions = order.selectedQuestions;
          final userInputs = order.userInputs;
          final transportationCost = order.transportationCost;
          final products = questions
              .where(
                (element) => element.list == 'product',
              )
              .toList();
          final services = questions
              .where(
                (element) => element.list == 'service',
              )
              .toList();
          final prices = fetchPrice(
            questions: questions,
            userInputs: userInputs,
            discount: 0,
            transportationCost: transportationCost,
          );
          final List<UserInputModel> inputs = prices[3];
          const String discount = '0';
          emit(
            FinalOrderSuccess(
              products: products,
              priceOfProducts: prices[1],
              services: services,
              priceOfServices: prices[0],
              discount: discount,
              totalPrice: prices[2],
              transportationCost: transportationCost,
              address: address,
              userInputs: inputs,
            ),
          );
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
          emit(FinalOrderFailed());
        });
      }
    });
  }

  List<dynamic> fetchPrice({
    required List<QuestionModel> questions,
    required List<int> userInputs,
    required int transportationCost,
    required int discount,
  }) {
    int priceOfProducts = 0;
    int priceOfServices = 0;
    int totalPrice = 0;

    int userInputIndex = 0;
    List<UserInputModel> itemsWithInputs = [];
    for (var questionIndex = 0;
        questionIndex < questions.length;
        questionIndex++) {
      final question = questions[questionIndex];
      if (question.list == 'service') {
        if (question.type == 'radio') {
          priceOfServices = priceOfServices + question.items[0].price;
        } else if (question.type == 'textbox') {
          for (var item in question.items) {
            priceOfServices =
                priceOfServices + item.price * userInputs[userInputIndex];
            final userInputModel = UserInputModel(
                item: item, userInput: userInputs[userInputIndex]);
            itemsWithInputs.add(userInputModel);
            userInputIndex++;
          }
        }
      } else if (question.list == 'product') {
        if (question.type == 'radio') {
          priceOfProducts = priceOfProducts + question.items[0].price;
        } else if (question.type == 'textbox') {
          for (var item in question.items) {
            priceOfProducts =
                priceOfProducts + item.price * userInputs[userInputIndex];
            userInputIndex++;
          }
        }
      }
    }
    totalPrice =
        priceOfServices + priceOfProducts + transportationCost - discount;
    final prices = [
      priceOfServices,
      priceOfProducts,
      totalPrice,
      itemsWithInputs,
    ];
    return prices;
  }
}
