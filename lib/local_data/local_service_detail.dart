import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/local_data/services/cctv.dart';
import 'package:bpbm2/local_data/services/central_antenna.dart';
import 'package:bpbm2/local_data/services/evaporative_cooler.dart';
import 'package:bpbm2/local_data/services/fire_alarm.dart';
import 'package:bpbm2/local_data/services/gas_cooler.dart';
import 'package:bpbm2/local_data/services/phone.dart';
import 'package:bpbm2/local_data/services/protector.dart';
import 'package:bpbm2/local_data/services/sensor.dart';
import 'package:bpbm2/local_data/services/switch.dart';
import 'package:bpbm2/local_data/services/ups.dart';
import 'package:bpbm2/local_data/services/video_phone.dart';
import 'package:bpbm2/local_data/services/wiring.dart';

List<ServiceDetailModel> localServiceDetail = [
  ServiceDetailModel.fromJson(evaporativeCoolerDetail),
  ServiceDetailModel.fromJson(gasCoolerDetail),
  ServiceDetailModel.fromJson(videoPhoneDetail),
  ServiceDetailModel.fromJson(centralAntennaDetail),
  ServiceDetailModel.fromJson(cctvDetail),
  ServiceDetailModel.fromJson(wiringDetail),
  ServiceDetailModel.fromJson(switchDetail),
  ServiceDetailModel.fromJson(upsDetail),
  ServiceDetailModel.fromJson(protectorDetail),
  ServiceDetailModel.fromJson(sensorDetail),
  ServiceDetailModel.fromJson(fireAlarmDetail),
  ServiceDetailModel.fromJson(phoneDetail),
];
