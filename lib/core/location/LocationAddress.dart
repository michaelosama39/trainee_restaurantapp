part of 'LocationAddressImports.dart';

class LocationAddress extends StatefulWidget {
  LocationAddress({super.key, this.isChangeLocationByUser = false});

  bool isChangeLocationByUser;

  @override
  State<StatefulWidget> createState() => _LocationAddress();
}

class _LocationAddress extends State<LocationAddress> {
  final LocationAddressData locationAddressData = LocationAddressData();

  @override
  void initState() {
    var loc = context.read<LocationCubit>().state.model;
    double lat = loc?.lat ?? 24.774265;
    double lng = loc?.lng ?? 46.738586;
    locationAddressData.locationModel = LocationModel(lat: lat, lng: lng);
    locationAddressData.getLocationAddress(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: locationAddressData._scaffold,
      appBar: AppBar(
        title: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            return Text(
              state.model!.address,
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 12.sp,
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BuildGoogleMapView(
        locationAddressData: locationAddressData,
      ),
      floatingActionButton: MaterialButton(
        child: const Text('تاكيد'),
        onPressed: () {
          locationAddressData.changeLocation(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
