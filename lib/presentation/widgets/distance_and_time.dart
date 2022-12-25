import 'package:flutter/material.dart';
import 'package:maps_app/constants/app_colors.dart';
import 'package:maps_app/data/models/place_directions.dart';

class DistanceAndTime extends StatelessWidget {
  const DistanceAndTime(
      {super.key,
      this.placeDirections,
      required this.isTimeAndDistanceVisible});

  final PlaceDirections? placeDirections;
  final bool isTimeAndDistanceVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isTimeAndDistanceVisible,
        child: Positioned(
          top: 0,
          bottom: 570,
          left: 0,
          right: 0,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  elevation: 6,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.access_time_filled,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections?.duration ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Flexible(
                flex: 1,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  elevation: 6,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.directions_car_filled,
                      color: AppColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections?.distance ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
