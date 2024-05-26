import 'package:bpbm2/data/models/service_list/service_detail_model.dart';
import 'package:bpbm2/local_data/services/burglar_alarm.dart';
import 'package:bpbm2/local_data/services/cctv.dart';
import 'package:bpbm2/local_data/services/central.dart';
import 'package:bpbm2/local_data/services/central_antenna.dart';
import 'package:bpbm2/local_data/services/damper.dart';
import 'package:bpbm2/local_data/services/drilling.dart';
import 'package:bpbm2/local_data/services/earth.dart';
import 'package:bpbm2/local_data/services/electrical_panel.dart';
import 'package:bpbm2/local_data/services/evaporative_cooler.dart';
import 'package:bpbm2/local_data/services/fan.dart';
import 'package:bpbm2/local_data/services/fire_alarm.dart';
import 'package:bpbm2/local_data/services/gas_cooler.dart';
import 'package:bpbm2/local_data/services/lighting.dart';
import 'package:bpbm2/local_data/services/phone.dart';
import 'package:bpbm2/local_data/services/protector.dart';
import 'package:bpbm2/local_data/services/remote.dart';
import 'package:bpbm2/local_data/services/sensor.dart';
import 'package:bpbm2/local_data/services/switch.dart';
import 'package:bpbm2/local_data/services/tv.dart';
import 'package:bpbm2/local_data/services/ups.dart';
import 'package:bpbm2/local_data/services/vent.dart';
import 'package:bpbm2/local_data/services/video_phone.dart';
import 'package:bpbm2/local_data/services/wifi.dart';
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
  ServiceDetailModel.fromJson(centralDetail),
  ServiceDetailModel.fromJson(electricalPanelDetail),
  ServiceDetailModel.fromJson(lightingDetail),
  ServiceDetailModel.fromJson(earthDetail),
  ServiceDetailModel.fromJson(drillingDetail),
  ServiceDetailModel.fromJson(damperDetail),
  ServiceDetailModel.fromJson(remoteDetail),
  ServiceDetailModel.fromJson(fanDetail),
  ServiceDetailModel.fromJson(tvDetail),
  ServiceDetailModel.fromJson(ventDetail),
  ServiceDetailModel.fromJson(burglarAlarmDetail),
  ServiceDetailModel.fromJson(wifiDetail),
];
