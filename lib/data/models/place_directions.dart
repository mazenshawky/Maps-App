import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDirections {
  late LatLngBounds bounds;
  late List<PointLatLng> polyLinePoints;
  late String distance;
  late String duration;

  PlaceDirections({
    required this.bounds,
    required this.polyLinePoints,
    required this.distance,
    required this.duration,
  });

  factory PlaceDirections.fromJson(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(json["routes"][0]);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(southwest: southwest, northeast: northeast);

    late String distance;
    late String duration;

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return PlaceDirections(
      bounds: bounds,
      polyLinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']),
      distance: distance,
      duration: duration,
    );
  }
}
