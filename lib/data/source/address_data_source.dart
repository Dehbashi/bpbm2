import 'dart:convert';

import 'package:bpbm2/common/constants.dart';
import 'package:bpbm2/common/methods/load_token.dart';
import 'package:bpbm2/data/models/address_model/address_model.dart';
import 'package:bpbm2/data/models/address_model/map_model.dart';
import 'package:http/http.dart' as http;

abstract class IAddressDataSource {
  Future<List<AddressModel>> fetchAddress();
  Future<int> fetchTransportationPrice({required int municipalityZone});
  Future<MapModel> fetchLocationFromMap({
    required double lat,
    required double lng,
  });
}

class AddressRemoteDataSource implements IAddressDataSource {
  @override
  Future<List<AddressModel>> fetchAddress() async {
    final token = await loadToken();
    final url = Uri.parse('$baseUrl/user/address/list');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
      'Authorization': '$tokenPrefix $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mainData = data['data']['data'] as List<dynamic>;
      final List<AddressModel> listOfAddresses = [];
      for (var address in mainData) {
        listOfAddresses.add(AddressModel.fromJson(address));
      }
      return listOfAddresses;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<int> fetchTransportationPrice({required int municipalityZone}) async {
    final url = Uri.parse('$baseUrl/calculation/map/price');
    final headers = {
      'Tokenpublic': tokenPublic,
      'Content-Type': contentType,
    };
    final body = jsonEncode({
      'data': municipalityZone,
    });
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as int;
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<MapModel> fetchLocationFromMap({
    required double lat,
    required double lng,
  }) async {
    final url =
        Uri.parse('https://api.neshan.org/v5/reverse?lat=$lat&lng=$lng');
    final headers = {
      'Api-Key': 'service.d630b9caaa0b43f991c8a324a0c971ee',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final fetchedLocation = MapModel.fromJson(data);
      return fetchedLocation;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
