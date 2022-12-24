import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bussiness_logic/cubit/maps/maps_cubit.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_colors.dart';
import '../../data/models/place.dart';
import 'my_place_item.dart';

// ignore: must_be_immutable
class MySearchBar extends StatelessWidget {
  MySearchBar({
    super.key,
    required this.placeSuggestionCallback,
    required this.selectedPlaceCallback,
    required this.goToMySearchedForLocation,
  });

  final Function(PlaceSuggestion) placeSuggestionCallback;

  final Function(Place) selectedPlaceCallback;

  final VoidCallback goToMySearchedForLocation;

  FloatingSearchBarController controller = FloatingSearchBarController();

  List<PlaceSuggestion> places = [];

  Widget buildSuggestionsBloc(BuildContext context) {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).places;
          if (places.isNotEmpty) {
            return buildPlacesList(context);
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildPlacesList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () {
            placeSuggestionCallback(places[index]);
            controller.close();
            _getSelectedPlaceDetails(context, places[index]);
          },
          child: MyPlaceItem(suggestion: places[index]),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void _getPlacesSuggestions(BuildContext context, String query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken);
  }

  void _getSelectedPlaceDetails(
      BuildContext context, PlaceSuggestion placeSelected) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceDetails(placeSelected.placeId, sessionToken);
  }

  Widget buildSelectedPlaceDetailsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceDetailsLoaded) {
          selectedPlaceCallback((state).place);
          goToMySearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionsBloc(context),
              buildSelectedPlaceDetailsBloc(),
            ],
          ),
        );
      },
      elevation: 6,
      hintStyle: const TextStyle(fontSize: 18),
      queryStyle: const TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: const BorderSide(style: BorderStyle.none),
      margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      height: 52,
      iconColor: AppColors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(microseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(microseconds: 500),
      onQueryChanged: (query) => _getPlacesSuggestions(context, query),
      onFocusChanged: (_) {},
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
