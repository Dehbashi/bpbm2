import 'package:bpbm2/data/models/time_model/time_model.dart';
import 'package:bpbm2/data/source/time_data_source.dart';

final timeRepository = TimeRepository(dataSource: TimeRemoteDataSource());

abstract class ITimeRepository {
  Future<List<TimeModel>> fetchTime();
}

class TimeRepository implements ITimeRepository {
  final ITimeDataSource dataSource;

  const TimeRepository({required this.dataSource});

  @override
  Future<List<TimeModel>> fetchTime() async {
    return dataSource.fetchTime();
  }
}
