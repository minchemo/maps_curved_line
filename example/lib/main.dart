import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_curved_line/maps_curved_line.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Curved Lines Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MapsPage(),
    );
  }
}

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Polyline> _polylines = Set();
  final Set<Marker> _markers = Set();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(12.947437, 77.685345),
    zoom: 15,
  );

  final LatLng _point1 = LatLng(12.947437, 77.681345);
  final LatLng _point2 = LatLng(12.948767, 77.689120);
  final LatLng _point3 = LatLng(12.947216, 77.680614);
  final LatLng _point4 = LatLng(12.948767, 77.609120);

  void prepareMarkers() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point1.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point1,
      icon: BitmapDescriptor.defaultMarker,
    ));

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point2.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point2,
      icon: BitmapDescriptor.defaultMarker,
    ));

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point3.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point3,
      icon: BitmapDescriptor.defaultMarker,
    ));

    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_point4.toString()),
      //_lastMapPosition is any coordinate which should be your default
      //position when map opens up
      position: _point4,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  void prepareCurvedPolylines() {
    _polylines.add(
        Polyline(
          polylineId: PolylineId("line 1"),
          visible: true,
          width: 2,
          //latlng is List<LatLng>
          patterns: [PatternItem.dash(30), PatternItem.gap(10)],
          points: MapsCurvedLines.getPointsOnCurve(_point1, _point2),
          color: Colors.blue,
        )
    );

    _polylines.add(
        Polyline(
          polylineId: PolylineId("line 2"),
          visible: true,
          width: 2,
          //latlng is List<LatLng>
          patterns: [PatternItem.dash(30), PatternItem.gap(10)],
          points: MapsCurvedLines.getPointsOnCurve(_point3, _point4),
          color: Colors.grey,
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    prepareMarkers();
    prepareCurvedPolylines();

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        polylines: _polylines,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
