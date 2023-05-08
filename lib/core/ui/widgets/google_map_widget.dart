import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/waiting_widget.dart';

import '../../constants/app/app_constants.dart';

class MapWidget extends StatefulWidget {
  final LatLng? myLocation;
  final Set<Marker>? markers;
  final Function? onMapCreated;
  static const String _myLocationMarkerId = 'myLocation';
  MapWidget({this.myLocation, this.markers, this.onMapCreated});
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final GoogleMapController _controller;
  Set<Marker> markers = {};
  late final BitmapDescriptor? customIcon;

  late final String mapStyle;
  bool isInitialized = true;
  bool myLocationSet = false;

  final LatLng _defaultLocation = const LatLng(24.738735, 46.710284);

  Future<void> _init() async {
    if (isInitialized) {
      mapStyle = await rootBundle.loadString(AppConstants.MAP_STYLE_JSON);
      await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(30.w, 45.h)),
              AppConstants.MARKER_ICON)
          .then((d) {
        customIcon = d;
      });
    }
    setState(() {
      isInitialized = false;
    });
    _setMyLocation();
  }

  void _setMapStyle() {
    _controller.setMapStyle(mapStyle);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _setMyLocation() {
    markers = {};
    if (widget.myLocation != null) {
      markers.removeWhere((element) =>
          element.markerId == const MarkerId(MapWidget._myLocationMarkerId));
      markers.add(Marker(
          markerId: const MarkerId(MapWidget._myLocationMarkerId),
          position: widget.myLocation!,
          icon: customIcon ?? BitmapDescriptor.defaultMarker));
    }
    if (widget.markers != null)
      widget.markers!.forEach((element) {
        markers.add(element);
      });

    if (!isInitialized && !myLocationSet && widget.myLocation != null) {
      _controller.moveCamera(CameraUpdate.newLatLng(widget.myLocation!));
      myLocationSet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setMyLocation();

    return !isInitialized
        ? GoogleMap(
            onMapCreated: (controller) {
              _controller = controller;
              _setMapStyle();

              widget.onMapCreated!();
            },
            initialCameraPosition: CameraPosition(
                target: widget.myLocation ?? _defaultLocation, zoom: 16),
            gestureRecognizers: Set()
              ..add(Factory<EagerGestureRecognizer>(
                  () => EagerGestureRecognizer())),
            zoomControlsEnabled: false,
            markers: markers,
          )
        : WaitingWidget();
  }
}
