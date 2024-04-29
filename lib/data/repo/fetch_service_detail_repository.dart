import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/data/source/fetch_service_detail_data_source.dart';

final fetchServiceDetailRepository = FetchServiceDetailRepository(
    dataSource: FetchServiceDetailRemoteDataSource());

abstract class IFetchServiceDetailRepository {
  Future<ServiceDetailModel> fetchServiceDetail({required int serviceId});
}

class FetchServiceDetailRepository implements IFetchServiceDetailRepository {
  final IFetchServiceDetailDataSource dataSource;

  const FetchServiceDetailRepository({required this.dataSource});

  @override
  Future<ServiceDetailModel> fetchServiceDetail(
      {required int serviceId}) async {
    return dataSource.fetchServiceDetail(serviceId: serviceId);
  }
}
