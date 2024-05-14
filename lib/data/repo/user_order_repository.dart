import 'package:bpbm2/data/models/order_model/order_detail_model.dart';
import 'package:bpbm2/data/models/order_model/user_order_model.dart';
import 'package:bpbm2/data/source/user_order_data_source.dart';

final userOrderRepository =
    UserOrderRepository(dataSource: UserOrderRemoteDataSource());

abstract class IUserOrderRepository {
  Future<List<UserOrderModel>> fetchUserOrderList();
  Future<OrderDetailModel> fetchUserOrderDetail({required int orderId});
}

class UserOrderRepository implements IUserOrderRepository {
  final IUserOrderDataSource dataSource;

  const UserOrderRepository({required this.dataSource});

  @override
  Future<List<UserOrderModel>> fetchUserOrderList() async {
    return dataSource.fetchUserOrderList();
  }

  @override
  Future<OrderDetailModel> fetchUserOrderDetail({required int orderId}) async {
    return dataSource.fetchUserOrderDetail(orderId: orderId);
  }
}
