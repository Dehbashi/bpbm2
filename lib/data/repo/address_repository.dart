import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/full_address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:bpbm2/data/source/address_data_source.dart';

final addressRepository =
    AddressRepository(dataSource: AddressRemoteDataSource());

abstract class IAddressRepository {
  Future<List<AddressModel>> fetchAddress();
  Future<int> fetchTransportationPrice({required int municipalityZone});
  Future<MapModel> fetchLocationFromMap({
    required double lat,
    required double lng,
  });
  Future<void> createAddress({required FullAddressModel address});
}

class AddressRepository implements IAddressRepository {
  final IAddressDataSource dataSource;

  const AddressRepository({required this.dataSource});

  @override
  Future<List<AddressModel>> fetchAddress() async {
    return dataSource.fetchAddress();
  }

  @override
  Future<int> fetchTransportationPrice({required int municipalityZone}) {
    return dataSource.fetchTransportationPrice(
        municipalityZone: municipalityZone);
  }

  @override
  Future<MapModel> fetchLocationFromMap({
    required double lat,
    required double lng,
  }) async {
    return dataSource.fetchLocationFromMap(lat: lat, lng: lng);
  }

  @override
  Future<void> createAddress({required FullAddressModel address}) async {
    return dataSource.createAddress(address: address);
  }
}
