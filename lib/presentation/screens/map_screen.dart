import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bussiness_logic/cubit/maps/maps_cubit.dart';
import 'package:maps_app/constants/app_colors.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/helpers/location_helper.dart';
import 'package:maps_app/presentation/widgets/distance_and_time.dart';
import 'package:maps_app/presentation/widgets/my_drawer.dart';
import 'package:maps_app/presentation/widgets/my_search_bar.dart';

import '../../data/models/place.dart';
import '../../data/models/place_directions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;

  // ignore: prefer_final_fields
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17,
  );

  Set<Marker> markers = {};
  late PlaceSuggestion _placeSuggestion;
  late Place _selectedPlace;
  late Marker _searchedForPlaceMarker;
  late Marker _currentLocationMarker;
  late CameraPosition _searchedForPlaceCameraPosition;

  PlaceDirections? placeDirections;
  bool progressIndicator = false;
  late List<LatLng> polylinePoints;
  bool isSearchedPlaceMarkerClicked = false;
  bool isTimeAndDistanceVisible = false;
  late String duration;
  late String distance;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation()
        .whenComplete(() => setState(() {}));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      polylines: placeDirections != null
          ? {
              Polyline(
                polylineId: const PolylineId('my_polyline'),
                color: AppColors.black,
                width: 4,
                points: polylinePoints,
              ),
            }
          : {},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  void _setCameraNewPosition() {
    _searchedForPlaceCameraPosition = CameraPosition(
      target: LatLng(
        _selectedPlace.result.geometry.location.lat,
        _selectedPlace.result.geometry.location.lng,
      ),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 13,
    );
  }

  Future<void> _goToMySearchedForLocation() async {
    _setCameraNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_searchedForPlaceCameraPosition));
    _setSearchedForPlaceMarker();
  }

  void _setSearchedForPlaceMarker() {
    _searchedForPlaceMarker = Marker(
      markerId: const MarkerId('1'),
      position: _searchedForPlaceCameraPosition.target,
      onTap: () {
        _setCurrentLocationMarker();
        setState(() {
          isSearchedPlaceMarkerClicked = true;
          isTimeAndDistanceVisible = true;
          _getDirections();
        });
      },
      infoWindow: InfoWindow(title: _placeSuggestion.description),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    _addMarkerToMarkers(_searchedForPlaceMarker);
  }

  void _setCurrentLocationMarker() {
    _currentLocationMarker = Marker(
      markerId: const MarkerId('2'),
      position: _myCurrentLocationCameraPosition.target,
      infoWindow: const InfoWindow(title: 'Your current location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    _addMarkerToMarkers(_currentLocationMarker);
  }

  void _addMarkerToMarkers(Marker marker) =>
      setState(() => markers.add(marker));

  void _clearMarkers() => setState(() => markers.clear());

  void _getPolylinePoints() {
    polylinePoints = placeDirections!.polyLinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

  void _getDirections() {
    BlocProvider.of<MapsCubit>(context).emitPlaceDirections(
      _myCurrentLocationCameraPosition.target,
      _searchedForPlaceCameraPosition.target,
    );
  }

  void _clearPolylines() {
    polylinePoints.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                ),
          MySearchBar(
            placeSuggestionCallback: (placeSuggestionValue) =>
                setState(() => _placeSuggestion = placeSuggestionValue),
            selectedPlaceCallback: (selectedPlaceValue) =>
                setState(() => _selectedPlace = selectedPlaceValue),
            placeDirectionsCallback: (placeDirectionsValue) =>
                setState(() => placeDirections = placeDirectionsValue),
            isTimeAndDistanceVisibleCallback: (isTimeAndDistanceVisibleValue) =>
                setState(() =>
                    isTimeAndDistanceVisible = isTimeAndDistanceVisibleValue),
            goToMySearchedForLocation: _goToMySearchedForLocation,
            getPolylinePoints: _getPolylinePoints,
            clearPolylines: _clearPolylines,
            clearMarkers: _clearMarkers,
            progressIndicator: progressIndicator,
          ),
          isSearchedPlaceMarkerClicked
              ? DistanceAndTime(
                  isTimeAndDistanceVisible: isTimeAndDistanceVisible,
                  placeDirections: placeDirections,
                )
              : Container(),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          onPressed: _goToMyCurrentLocation,
          backgroundColor: AppColors.blue,
          child: const Icon(Icons.place, color: AppColors.white),
        ),
      ),
    );
  }
}
