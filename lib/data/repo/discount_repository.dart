import 'package:bpbm2/data/source/discount_data_source.dart';

final discountRepository =
    DiscountRepository(dataSource: DiscountRemoteDataSource());

abstract class IDiscountRepository {
  Future<void> fetchDiscount({
    required String discount,
    required int value,
  });
}

class DiscountRepository implements IDiscountRepository {
  final IDiscountDataSource dataSource;

  const DiscountRepository({required this.dataSource});

  @override
  Future<void> fetchDiscount(
      {required String discount, required int value}) async {
    return dataSource.fetchDiscount(
      discount: discount,
      value: value,
    );
  }
}
