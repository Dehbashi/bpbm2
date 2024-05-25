import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/dialogs/loading_screen.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/date_model/date_model.dart';
import 'package:bpbm2/data/models/order_registration_model/order_registration_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_address_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_profile_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_question_model/register_question_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_service_model.dart';
import 'package:bpbm2/data/models/order_registration_model/register_time_model.dart';
import 'package:bpbm2/data/models/question_model/question_item_model.dart';
import 'package:bpbm2/data/models/question_model/question_model.dart';
import 'package:bpbm2/data/models/question_model/user_input_model.dart';
import 'package:bpbm2/data/repo/address_repository.dart';
import 'package:bpbm2/data/repo/discount_repository.dart';
import 'package:bpbm2/data/repo/register_order_repository.dart';
import 'package:bpbm2/screens/stepper_screen/methods/load_order_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'final_order_event.dart';
part 'final_order_state.dart';

class FinalOrderBloc extends Bloc<FinalOrderEvent, FinalOrderState> {
  final BuildContext context;
  FinalOrderBloc(this.context) : super(FinalOrderInitial()) {
    List<QuestionModel> products = [];
    List<dynamic> prices = [];
    List<QuestionModel> services = [];
    String discount = '0';
    int newDiscount = 0;
    int transportationCost = 0;
    AddressModel address = AddressModel.empty();
    List<UserInputModel> inputs = [];

    on<FinalOrderEvent>((event, emit) async {
      if (event is FinalOrderStarted) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        await fetchFinalOrderData().then((order) {
          address = order.selectedAddress;
          final questions = order.selectedQuestions;
          final userInputs = order.userInputs;
          transportationCost = order.transportationCost;
          products = questions
              .where(
                (element) => element.list == 'product',
              )
              .toList();
          services = questions
              .where(
                (element) => element.list == 'service',
              )
              .toList();
          prices = fetchPrice(
            questions: questions,
            userInputs: userInputs,
            discount: int.parse(discount),
            transportationCost: transportationCost,
          );
          inputs = prices[3];
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
              isDiscountLoading: false,
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

      if (event is RegisterDiscount) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال محاسبه',
        );
        await discountRepository
            .fetchDiscount(
          discount: event.discount,
          servicePrice: prices[0],
        )
            .then((value) {
          newDiscount = value;
          print(prices[0]);
          print(newDiscount);
          emit(
            FinalOrderSuccess(
              products: products,
              priceOfProducts: prices[1],
              services: services,
              priceOfServices: prices[0],
              discount: newDiscount.toString(),
              totalPrice: prices[2] - newDiscount,
              transportationCost: transportationCost,
              address: address,
              userInputs: inputs,
              isDiscountLoading: false,
            ),
          );
          LoadingScreen.instance().hide();
        }).catchError((e) {
          LoadingScreen.instance().hide();
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
              isDiscountLoading: false,
            ),
          );
          customErrorMessenger(
            context: context,
            message: 'کد تخفیف معتبر نیست',
          );
        });
      }

      if (event is RegisterFinalOrder) {
        LoadingScreen.instance().show(
          context: context,
          text: 'در حال بارگذاری',
        );
        final orderData = await fetchFinalOrderData();
        final neshanAddress = await addressRepository.fetchLocationFromMap(
          lat: double.parse(orderData.selectedAddress.lat),
          lng: double.parse(orderData.selectedAddress.lng),
        );
        final addressType = orderData.newAddress ? 'mark' : 'select';
        final savedAddress = RegisterAddressModel(
          city: neshanAddress.city != null
              ? utf8.decode(neshanAddress.city!.codeUnits)
              : '',
          county: neshanAddress.county != null
              ? utf8.decode(neshanAddress.county!.codeUnits)
              : '',
          district: neshanAddress.district != null
              ? utf8.decode(neshanAddress.district!.codeUnits)
              : '',
          formattedAddress:
              utf8.decode(neshanAddress.formattedAddress.codeUnits),
          houseNumber: orderData.selectedAddress.houseNumber,
          inOddEvenZone: neshanAddress.inOddEvenZone,
          inTrafficZone: neshanAddress.inTrafficZone,
          lat: orderData.selectedAddress.lat,
          lng: orderData.selectedAddress.lng,
          municipalityZone: neshanAddress.municipalityZone,
          neighbourhood: utf8.decode(neshanAddress.neighborhood.codeUnits),
          place: neshanAddress.place != null
              ? utf8.decode(neshanAddress.place!.codeUnits)
              : '',
          routeName: neshanAddress.routeName != null
              ? utf8.decode(neshanAddress.routeName!.codeUnits)
              : '',
          routeType: neshanAddress.routeType,
          state: neshanAddress.state != null
              ? utf8.decode(neshanAddress.state!.codeUnits)
              : '',
          status: neshanAddress.status,
          transportationCost: transportationCost,
          type: addressType,
          unit: orderData.selectedAddress.unit,
          village: neshanAddress.village,
        );
        final savedDate = DateModel(
          id: orderData.selectedDate.id,
          text: orderData.selectedDate.text,
          title: orderData.selectedDate.title,
        );
        final savedTime = RegisterTimeModel(
          id: orderData.timeId,
          title: orderData.selectedTime,
          value: orderData.timeValue,
        );
        final savedProfile = RegisterProfileModel(
          firstName: orderData.firstName,
          lastName: orderData.lastName,
        );

        List<RegisterQuestionModel> questions = [];
        List<RegisterQuestionModel> products = [];
        for (var item in orderData.selectedQuestions) {
          int index = orderData.selectedQuestions.indexOf(item);
          final selectedQuestion = orderData.selectedQuestions[index];
          final selectedQuestionService =
              orderData.selectedQuestionServices[index];
          List<QuestionItemModel> data =
              orderData.selectedQuestions[index].items;

          if (selectedQuestion.list == 'service') {
            final question = RegisterQuestionModel(
              data: data,
              id: selectedQuestion.id,
              nextRelation: selectedQuestion.items[0].nextRelation,
              number: 1,
              question: selectedQuestionService,
              relationId: selectedQuestionService.relation.now,
              title: selectedQuestion.title,
              type: selectedQuestion.list,
              questionType: selectedQuestion.type,
            );
            questions.add(question);
          } else if (selectedQuestion.list == 'product') {
            final product = RegisterQuestionModel(
              data: data,
              id: selectedQuestion.id,
              nextRelation: selectedQuestion.items[0].nextRelation,
              number: 1,
              question: selectedQuestionService,
              relationId: selectedQuestionService.relation.now,
              title: selectedQuestion.title,
              type: selectedQuestion.list,
              questionType: selectedQuestion.type,
            );
            products.add(product);
          }
        }

        final savedService = RegisterServiceModel(
          id: event.serviceId,
          status: 1,
          title: questions[0].question.serviceTitle!,
          url: questions[0].question.serviceTitle!.replaceAll(' ', '_'),
        );

        final order = OrderRegistrationModel(
          address: savedAddress,
          authUser: orderData.cellNumber,
          date: savedDate,
          details: event.discription,
          discount: newDiscount.toString(),
          product: products,
          profile: savedProfile,
          questions: questions,
          service: savedService,
          time: savedTime,
        );

        await registerOrderRepository.registerOrder(order: order).then((order) {
          emit(
            FinalStep(
              orderId: order.id,
            ),
          );
          LoadingScreen.instance().hide();
        }).catchError((e) {
          print(e.toString());
          LoadingScreen.instance().hide();
          customErrorMessenger(
            context: context,
            message: 'خطای نامشخص',
          );
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
            final userInputModel = UserInputModel(
                item: item, userInput: userInputs[userInputIndex]);
            itemsWithInputs.add(userInputModel);
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
