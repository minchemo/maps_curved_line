# maps_curved_line

[![pub package](https://img.shields.io/pub/v/maps_curved_line.svg)](https://pub.dartlang.org/packages/maps_curved_line)

A package to help draw curved lines on [Google Maps](https://pub.dev/packages/google_maps_flutter).
Generates a list of LatLng which can be used to render a curved polyline between the given
start and end LatLng.

<p>
  <img src="https://user-images.githubusercontent.com/8823044/78174319-96853100-7448-11ea-9389-fdd0dd12579b.png" width="290" />
  <img src="https://user-images.githubusercontent.com/8823044/78174332-9ab14e80-7448-11ea-80c6-0d2b825d853a.png" width="290" />
</p>

## Installation

First, add `maps_curved_lines` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Usage:

``` dart
import 'package:maps_curved_line/maps_curved_line.dart';
.
.

class _MapsPageState extends State<MapsPage> {

  final Set<Polyline> _polylines = Set();

  final LatLng _point1 = LatLng(12.947437, 77.681345);
  final LatLng _point2 = LatLng(12.948767, 77.689120);

  @override
  Widget build(BuildContext context) {
    _polylines.add(
        Polyline(
            polylineId: PolylineId("line 1"),
            visible: true,
            width: 2,
            //latlng is List<LatLng>
            patterns: [PatternItem.dash(30), PatternItem.gap(10)],
            points: MapsCurvedLines.getPointsOnCurve(_point1, _point2), // Invoke lib to get curved line points
            color: Colors.blue,
        )
    );

    return new Scaffold(
      body: GoogleMap(
        // Configure google maps widget are required
        .
        polylines: _polylines, // Add constructed polyline for curved line
        .
        .
      ),
    );
  }
}
```