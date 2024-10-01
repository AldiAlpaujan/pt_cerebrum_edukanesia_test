import 'package:aldi_test/helper/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class WeatherData {
  static final Dio _dio = Dio();
  static const String _apiKey = "322187fe108a6f43d8eeb5f71b624a30";

  static final Map<String, String> weatherDescriptions = {
    'overcast clouds': 'awan mendung',
    'clear sky': 'langit cerah',
    'light rain': 'hujan ringan',
    'moderate rain': 'hujan sedang',
    'heavy rain': 'hujan deras',
    'very heavy rain': 'hujan sangat deras',
    'light intensity shower rain': 'hujan gerimis ringan',
    'shower rain': 'hujan gerimis',
    'heavy intensity shower rain': 'hujan gerimis deras',
    'thunderstorm': 'hujan petir',
    'snow': 'salju',
    'mist': 'kabut',
    'fog': 'kabut tebal',
    'haze': 'kabut asap',
    'dust': 'debu',
    'sand': 'pasir',
    'tornado': 'tornado',
    'tropical storm': 'badai tropis',
    'tropical rainstorm': 'badai hujan tropis',
    'clear': 'cerah',
    'few clouds': 'sedikit awan',
    'scattered clouds': 'awan tersebar',
    'broken clouds': 'awan pecah',
  };

  static Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Minta pengguna mengaktifkan layanan lokasi
      return Future.error('Layanan lokasi dinonaktifkan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Izin lokasi secara permanen ditolak, tidak dapat meminta izin.');
    }

    // Mengatur pengaturan lokasi
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, // Akurasi tinggi
      distanceFilter: 10, // Filter jarak dalam meter
    );

    // Mendapatkan posisi saat ini dengan pengaturan lokasi
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  static Future<List<Map<String, dynamic>>> getWeather() async {
    try {
      Position position = await _getCurrentLocation();
      double lat = position.latitude;
      double lon = position.longitude;
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'units': 'metric',
          'appid': _apiKey,
          "cnt": 16,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        // Mendapatkan tanggal hari ini dan besok
        final now = DateTime.now();
        final today = DateFormat('yyyy-MM-dd').format(now);
        final tomorrow = DateFormat('yyyy-MM-dd').format(
          now.add(const Duration(days: 1)),
        );
        final simplifiedWeatherData = (data['list'] as List).where((item) {
          String date = item['dt_txt'].split(' ')[0];
          return date == today || date == tomorrow;
        }).map((item) {
          return {
            'dateTime': item['dt_txt'],
            'temperature': item['main']['temp'],
            'feelsLike': item['main']['feels_like'],
            'humidity': item['main']['humidity'],
            'code': item['weather'][0]['id'],
            'weatherDescription':
                weatherDescriptions[item['weather'][0]['description']],
          };
        }).toList();
        return [
          {
            'id': 1,
            ...simplifiedWeatherData.firstWhere(
              (e) => DateTime.parse(e['dateTime']).isAfter(now),
            )
          },
          {
            'id': 2,
            ...simplifiedWeatherData.firstWhere(
              (e) => DateTime.parse(e['dateTime']).isAfter(
                now.add(const Duration(days: 1)),
              ),
            ),
          },
        ];
      } else {
        info(message: "Ops, gagal mengambil data cuaca");
        return [];
      }
    } catch (e) {
      if (kDebugMode) print(e);
      info(message: "Ops, gagal mengambil data cuaca");
      return [];
    }
  }
}
