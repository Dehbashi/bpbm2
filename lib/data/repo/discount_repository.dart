import 'package:bpbm2/data/source/discount_data_source.dart';

final discountRepository =
    DiscountRepository(dataSource: DiscountRemoteDataSource());

abstract class IDiscountRepository {
  Future<int> fetchDiscount({
    required String discount,
    required int servicePrice,
  });
}

class DiscountRepository implements IDiscountRepository {
  final IDiscountDataSource dataSource;

  const DiscountRepository({required this.dataSource});

  @override
  Future<int> fetchDiscount(
      {required String discount, required int servicePrice}) async {
    return dataSource.fetchDiscount(
      discount: discount,
      servicePrice: servicePrice,
    );
  }
}
