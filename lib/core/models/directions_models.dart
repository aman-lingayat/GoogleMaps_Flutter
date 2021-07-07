import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds? bounds;
  final List<PointLatLng>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;

  const Directions({
    @required this.bounds,
    @required this.polylinePoints,
    @required this.totalDistance,
    @required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map['routes'] as List).isEmpty) {
      debugPrint("not available");
    }

    // Get route information
    final map1 = map['routes'] as List;
    final data = Map<String, dynamic>.from(
        ((map1.isNotEmpty) ? map1.first : null) as Map<dynamic, dynamic>);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'] as double, northeast['lng'] as double),
      southwest: LatLng(southwest['lat'] as double, southwest['lng'] as double),
    );

    // Distance & Duration
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'] as String;
      duration = leg['duration']['text'] as String;
    }

    return Directions(
      bounds: bounds,
      polylinePoints: PolylinePoints()
          .decodePolyline(data['overview_polyline']['points'] as String),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
