import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/data/models/place.dart';
import 'package:maps_app/data/models/place_directions.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/data/webservices/places_web_services.dart';

class MapsRepository {
  final PlacesWebServices placesWebServices;

  MapsRepository(this.placesWebServices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebServices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebServices.getPlaceLocation(placeId, sessionToken);

    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
        await placesWebServices.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}
