import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:bpbm2/data/source/fetch_service_list_data_source.dart';

final fetchServiceListRepository =
    FetchServiceListRepository(dataSource: FetchServiceListRemoteDataSource());

abstract class IFetchServiceListRepository {
  Future<List<ServiceListModel>> fetchServiceList();
}

class FetchServiceListRepository implements IFetchServiceListRepository {
  final IFetchServiceListDataSource dataSource;

  const FetchServiceListRepository({required this.dataSource});

  @override
  Future<List<ServiceListModel>> fetchServiceList() async {
    return dataSource.fetchServiceList();
  }
}
