import 'dart:convert';

import 'package:synapsis_survei/data/models/weather_model.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/constants/dummy_data_json.dart';
import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Zocca',
    main: 'Rain',
    description: 'moderate rain',
    iconCode: '10d',
    temperature: 298.48,
    pressure: 1015,
    humidity: 64,
  );
  test('should be subclass of weather entity', () async {
    //assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson(DummyData.weatherJson));
    //act
    final result = WeatherModel.fromJson(jsonMap);
    //assert
    expect(result, testWeatherModel);
  });

  test('should retrun a json map containing proper data', () async {
    //act
    final result = testWeatherModel.toJson();
    //assert
    final expectedMap = {
      "weather": [
        {
          "main": "Rain",
          "description": "moderate rain",
          "icon": "10d",
        },
      ],
      "main": {"temp": 298.48, "pressure": 1015, "humidity": 64},
      "name": "Zocca"
    };
    expect(result, expectedMap);
  });
}
