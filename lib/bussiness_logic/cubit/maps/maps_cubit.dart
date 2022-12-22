// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:maps_app/data/models/place.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/data/repository/maps_repo.dart';
import 'package:meta/meta.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit(this.mapsRepository) : super(MapsInitial());

  final MapsRepository mapsRepository;

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
}
