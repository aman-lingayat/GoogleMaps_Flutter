import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gmaps_flutter/core/constant/key.dart';
import 'package:gmaps_flutter/core/models/directions_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    @required LatLng? origin,
    @required LatLng? destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    // response.realUri;
    debugPrint(response.realUri.toString());

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }
}
//AIzaSyBYLGlxoGaaUbsDDz81wot45NKjwZdnKX8
