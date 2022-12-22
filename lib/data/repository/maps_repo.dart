import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/data/webservices/places_web_services.dart';

class MapsRepository {
  final PlacesWebServices placesWebServices;

  MapsRepository(this.placesWebServices);

  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebServices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestions.fromJson(suggestion))
        .toList();
  }
}
