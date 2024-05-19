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
            discount: 0,
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
            isDiscountLoading: true,
          ),
        );
        Future.delayed(const Duration(seconds: 1));
        await discountRepository
            .fetchDiscount(
          discount: event.discount,
          value: 0,
        )
            .then((response) {
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
        }).catchError((e) {
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
        print(orderData.selectedAddress.lat);
        final neshanAddress = await addressRepository.fetchLocationFromMap(
          lat: double.parse(orderData.selectedAddress.lat),
          lng: double.parse(orderData.selectedAddress.lng),
        );
        // final order = RegisterModel(
        //   address: orderData.selectedAddress,
        //   newAddress: false,
        //   cellNumber: orderData.cellNumber,
        //   dateId: orderData.selectedDate.id,
        //   description: event.discription,
        //   discount: discount,
        //   firstName: orderData.firstName,
        //   lastName: orderData.lastName,
        //   selectedQuestions: orderData.selectedQuestions,
        //   serviceId: event.serviceId,
        //   timeId: orderData.timeId,
        //   transportationcost: orderData.transportationCost,
        // );
        final savedAddress = RegisterAddressModel(
          city: neshanAddress.city,
          county: neshanAddress.county,
          district: neshanAddress.district,
          formattedAddress: neshanAddress.formattedAddress,
          houseNumber: orderData.selectedAddress.houseNumber,
          inOddEvenZone: neshanAddress.inOddEvenZone,
          inTrafficZone: neshanAddress.inTrafficZone,
          lat: orderData.selectedAddress.lat,
          lng: orderData.selectedAddress.lng,
          municipalityZone: neshanAddress.municipalityZone,
          neighbourhood: neshanAddress.neighborhood,
          place: neshanAddress.place,
          routeName: neshanAddress.routeName,
          routeType: neshanAddress.routeType,
          state: neshanAddress.state,
          status: neshanAddress.status,
          transportationCost: transportationCost,
          type: 'select',
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
        for (var item in orderData.selectedQuestions) {
          int index = orderData.selectedQuestions.indexOf(item);
          final selectedQuestion = orderData.selectedQuestions[index];
          final selectedQuestionService =
              orderData.selectedQuestionServices[index];
          List<QuestionItemModel> data =
              orderData.selectedQuestions[index].items;

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
          discount: null,
          product: [],
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
