import 'package:bpbm2/data/models/order_registration_model/order_registration_model.dart';
import 'package:bpbm2/data/models/register_order_model/register_model.dart';
import 'package:bpbm2/data/models/register_order_model/registered_order_model.dart';
import 'package:bpbm2/data/source/register_order_data_source.dart';

final registerOrderRepository =
    RegisterOrderRepository(dataSource: RegisterOrderRemoteDataSource());

abstract class IRegisterOrderRepository {
  Future<RegisteredOrderModel> registerOrder(
      {required OrderRegistrationModel order});
}

class RegisterOrderRepository implements IRegisterOrderRepository {
  final IRegisterOrderDataSource dataSource;

  const RegisterOrderRepository({required this.dataSource});

  @override
  Future<RegisteredOrderModel> registerOrder(
      {required OrderRegistrationModel order}) async {
    return dataSource.registerOrder(order: order);
  }
}
