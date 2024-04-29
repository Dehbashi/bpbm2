import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/data/source/fetch_service_detail_data_source.dart';
import 'package:flutter/material.dart';

final fetchServiceDetailRepository = FetchServiceDetailRepository(
    dataSource: FetchServiceDetailRemoteDataSource());

abstract class IFetchServiceDetailRepository {
  Future<ServiceDetailModel> fetchServiceDetail({required int serviceId});
  // Future<Image> fetchServiceIcons({
  //   required int serviceId,
  //   required int iconNumber,
  // });
}

class FetchServiceDetailRepository implements IFetchServiceDetailRepository {
  final IFetchServiceDetailDataSource dataSource;

  const FetchServiceDetailRepository({required this.dataSource});

  @override
  Future<ServiceDetailModel> fetchServiceDetail(
      {required int serviceId}) async {
    return dataSource.fetchServiceDetail(serviceId: serviceId);
  }

  // @override
  // Future<Image> fetchServiceIcons(
  //     {required int serviceId, required int iconNumber}) async {
  //   return dataSource.fetchServiceIcons(
  //     serviceId: serviceId,
  //     iconNumber: iconNumber,
  //   );
  // }
}
