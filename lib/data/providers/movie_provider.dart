import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../bloc/export.dart';

class MovieProvider {
  final dio = Dio(BaseOptions(baseUrl: 'https://swapi.dev/api'));

  Future<List<Movie>> getAllMovie() async {
    final response = await dio.get('/films');
    List data = response.data['results'];
    return data.map((e) => Movie.fromJson(e)).toList();
  }

  Future<Movie> getMovieById(int id) async {
    final response = await dio.get('/films/$id');
    return Movie.fromJson(response.data);
  }

  Future<List<People>> characters(List<String> urls) async {
    final data = [];
    for (var url in urls) {
      final response = await dio.get(url);
      data.add(response.data);
    }
    return data.map((e) => People.fromJson(e)).toList();
  }

  Future<List<Planets>> planets(List<String> urls) async {
    final data = [];
    for (var url in urls) {
      final response = await dio.get(url);
      data.add(response.data);
    }
    return data.map((e) => Planets.fromJson(e)).toList();
  }

  Future<List<Starships>> starships(List<String> urls) async {
    final data = [];
    for (var url in urls) {
      final response = await dio.get(url);
      data.add(response.data);
    }
    return data.map((e) => Starships.fromJson(e)).toList();
  }

  Future<List<Vehicles>> vehicles(List<String> urls) async {
    final data = [];
    for (var url in urls) {
      final response = await dio.get(url);
      data.add(response.data);
    }
    return data.map((e) => Vehicles.fromJson(e)).toList();
  }

  Future<List<Species>> species(List<String> urls) async {
    final data = [];
    for (var url in urls) {
      final response = await dio.get(url);
      data.add(response.data);
    }
    return data.map((e) => Species.fromJson(e)).toList();
  }

  Future<List<LatLng>> line(List<LatLng> line) async {
    String url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${line[0].longitude},${line[0].latitude};${line[1].longitude},${line[1].latitude}?geometries=geojson&access_token=sk.eyJ1IjoiZmFyY2hhbmFrYmFyIiwiYSI6ImNtMGd5bTd3NjA0cm4yanBiN2ljanc0aWkifQ.knlWSIpgbShHO-50GZCOBQ';
    final response = await dio.get(url);
    final json = response.data;
    final route = json['routes'][0]['geometry']['coordinates'];

    // Mengubah koordinat dari API ke List<LatLng>
    final result = (route as List).map((point) {
      return LatLng(point[1], point[0]);
    }).toList();
    // print(result);
    return result;
  }
}
