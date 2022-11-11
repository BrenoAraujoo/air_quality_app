import 'package:air_quality_app/feature/datas/waqi_data.dart';
import 'package:air_quality_app/feature/models/waqi_model.dart';
import 'package:either_dart/either.dart';

class WaqiRepository {
  final WaqiData _data;

  WaqiRepository(this._data);

  Future<Either<Exception, WaqiModel>> get({
    required String longitude,
    required String latitude,
  }) async {
    final result = await _data.get(
      longitude: longitude,
      latitude: latitude,
    );

    if (result.statusCode != 200) {
      return Left(Exception(result.data));
    }

    var waqi = WaqiModel.fromJson(result.data);

    return Right(waqi);
  }
}
