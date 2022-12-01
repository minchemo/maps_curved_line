library maps_curved_lines;

import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'maps/spherical_utils.dart';

class MapsCurvedLines {
  static List<LatLng> getPointsOnCurve(
      LatLng startLocation, LatLng endLocation) {
    // https://medium.com/better-programming/curved-lines-on-google-maps-2938bbb15f6a
    List<LatLng> path = [];
    double angle = pi / 2;
    // ignore: non_constant_identifier_names
    double SE =
        SphericalUtils.computeDistanceBetween(startLocation, endLocation)
            as double;
    // ignore: non_constant_identifier_names
    double ME = SE / 2.0;
    double R = ME / sin(angle / 2);
    // ignore: non_constant_identifier_names
    double MO = R * cos(angle / 2);

    double heading =
        SphericalUtils.computeHeading(startLocation, endLocation) as double;
    LatLng mCoordinate =
        SphericalUtils.computeOffset(startLocation, ME, heading);

    double direction =
        (startLocation.longitude - endLocation.longitude > 0) ? -1.0 : 1.0;
    double angleFromCenter = 90.0 * direction;
    LatLng oCoordinate = SphericalUtils.computeOffset(
        mCoordinate, MO, heading + angleFromCenter);

    path.add(endLocation);

    int num = 100;

    double initialHeading =
        SphericalUtils.computeHeading(oCoordinate, endLocation) as double;
    double degree = (180.0 * angle) / pi;

    for (int i = 1; i <= num; i++) {
      double step = i.toDouble() * (degree / num.toDouble());
      double heading = (-1.0) * direction;
      LatLng pointOnCurvedLine = SphericalUtils.computeOffset(
          oCoordinate, R, initialHeading + heading * step);
      path.add(pointOnCurvedLine);
    }

    path.add(startLocation);

    return path;
  }
}
