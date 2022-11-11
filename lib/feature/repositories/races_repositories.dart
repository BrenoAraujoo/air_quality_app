import 'package:air_quality_app/feature/datas/air_quality_data.dart';
import 'package:air_quality_app/feature/models/race_model.dart';
import 'package:either_dart/either.dart';

class RacesRepositories {
  final AirQualityData _data;

  RacesRepositories(this._data);

  Future<Either<Exception, List<RacerModel>>> get() async {
    final result = await _data.get();

    if (result.statusCode != 200) {
      return Left(Exception(result.data));
    }

    final List datas = result.data;

    var racer = datas.map((racer) {
      return RacerModel.fromJson(racer);
    }).toList();

    return Right(racer);
  }

  Future<Either<Exception, RacerModel>> send(RacerModel model) async {
    final result = await _data.send(RacerModel.toJson(model));

    if (result.statusCode != 201) {
      return Left(Exception(result.data));
    }

    var racer = RacerModel.fromJson(result.data);

    return Right(racer);
  }
}
