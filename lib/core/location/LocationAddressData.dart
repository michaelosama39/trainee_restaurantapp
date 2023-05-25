part of 'LocationAddressImports.dart';

class LocationAddressData {
  final GlobalKey<ScaffoldState> _scaffold =   GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> controller = Completer();
  late LocationModel locationModel;
  final apiKey = "AIzaSyB4d19CAL7u_hJ8k4P7EaQFcnner_Q9KEo";


  void getLocationAddress(BuildContext context) async {
    LatLng loc = LatLng(locationModel.lat,locationModel.lng);
    String address = await Utils.getAddress(loc,context);
    locationModel.address=address;
    context.read<LocationCubit>().onLocationUpdated(locationModel);
  }


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void changeLocation(BuildContext context) async {
    if (locationModel.address.isEmpty) {
      Toast.show('selectLocation');
      return;
    }
    context.read<LocationCubit>().onLocationUpdated(locationModel);

    Navigator.pop(context);
  }
 }
