import 'package:bpbm2/data/models/faq_list/faq_model.dart';
import 'package:bpbm2/data/source/fetch_faq_data_source.dart';

final fetchFaqRepository =
    FetchFaqRepository(dataSource: FetchFaqRemoteDataSource());

abstract class IFetchFaqRepository {
  Future<List<FaqModel>> fetchFaqs();
}

class FetchFaqRepository implements IFetchFaqRepository {
  final IFetchFaqDataSource dataSource;

  const FetchFaqRepository({required this.dataSource});

  @override
  Future<List<FaqModel>> fetchFaqs() async {
    return dataSource.fetchFaqs();
  }
}
