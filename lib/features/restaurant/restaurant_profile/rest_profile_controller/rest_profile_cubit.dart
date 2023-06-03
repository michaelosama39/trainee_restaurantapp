import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/navigator_home/view/navigator_home_view.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/data/models/restaurants_model.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/data/models/update_rest_profile_model.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/data/repositories/RestProfileRepo.dart';

import '../../../../core/location/LocationAddressImports.dart';
import '../../../../core/location/location_cubit/location_cubit.dart';
import '../../../../core/location/model/location_model.dart';
import '../../../../core/ui/toast.dart';
import '../../../../core/utils/Utils.dart';

part 'rest_profile_state.dart';

class RestProfileCubit extends Cubit<RestProfileState> {
  RestProfileCubit() : super(RestProfileInitial());

  static RestProfileCubit of(context) => BlocProvider.of(context);

  final restProfileRepo = RestProfileRepo();

  RestaurantsModel? restaurantsModel;

  String? imageNetwork;
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  String? logoArNetwork;
  String? logoEnNetwork;
  String? coveArNetwork;
  String? coveEnNetwork;
  TextEditingController phoneController = TextEditingController();
  TextEditingController commercialRegisterNumberController =
      TextEditingController();
  String? commercialRegisterDoc;
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildNumController = TextEditingController();
  TextEditingController mangerController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instegramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  FocusNode descAr = FocusNode();
  FocusNode descEn = FocusNode();

  TextEditingController descArController = TextEditingController();
  TextEditingController descEnController = TextEditingController();

  File? fileLogoAr;
  File? fileLogoEn;
  File? fileCoveEn;
  File? fileCoveAr;
  File? fileCommercialRegisterDoc;

  String? imgLogoAr;
  String? imgLogoEn;
  String? imgCoveEn;
  String? imgCoveAr;
  String? imgCommercialRegisterDoc;

  final LocationCubit locationCubit = LocationCubit();

  Future uploadImage(BuildContext context, File file) async {
    emit(UploadImageLoading());
    final res = await restProfileRepo.uploadImage(file);
    res.fold(
      (err) {
        Toast.show(err);
        emit(RestProfileInitial());
      },
      (res) async {
        if (file == fileLogoAr) {
          imgLogoAr = res;
        } else if (file == fileLogoEn) {
          imgLogoEn = res;
        } else if (file == fileCoveEn) {
          imgCoveEn = res;
        } else if (file == fileCoveAr) {
          imgCoveAr = res;
        } else if (file == fileCommercialRegisterDoc) {
          imgCommercialRegisterDoc = res;
        }
        emit(UploadImageLoaded());
      },
    );
  }

  Future updateRestaurantProfile(BuildContext context) async {
    UpdateRestProfileModel updateRestProfileModel = UpdateRestProfileModel(
      id: restaurantsModel!.id,
      arName: nameArController.text,
      enName: nameEnController.text,
      arDescription: descArController.text,
      enDescription: descEnController.text,
      arLogo: imgLogoAr== null ? restaurantsModel!.arLogo : imgLogoAr,
      enLogo: imgLogoEn== null ? restaurantsModel!.enLogo : imgLogoEn,
      arCover: imgCoveAr== null ? restaurantsModel!.arCover : imgCoveAr,
      enCover: imgCoveEn == null ? restaurantsModel!.enCover : imgCoveEn,
      commercialRegisterNumber: commercialRegisterNumberController.text,
      commercialRegisterDocument: imgCommercialRegisterDoc == null ? restaurantsModel!.commercialRegisterDocument : imgCommercialRegisterDoc,
      phoneNumber: phoneController.text,
      facebookUrl: facebookController.text,
      instagramUrl: instegramController.text,
      twitterUrl: twitterController.text,
      websiteUrl: websiteController.text,
      latitude: locationCubit.state.model!.lat,
      longitude: locationCubit.state.model!.lng,
    );

    print(await updateRestProfileModel.toJson());

    emit(UpdateRestProfileLoading());
    final res = await restProfileRepo.updateRestProfile(updateRestProfileModel);
    res.fold(
      (err) {
        Toast.show(err);
        emit(UpdateRestProfileError());
      },
      (res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavigatorScreen(homeType: 3)),
            (route) => false);
        emit(UpdateRestProfileLoaded());
      },
    );
  }

  Future getRestaurantProfile(BuildContext context) async {
    emit(GetRestProfileLoading());
    final res = await restProfileRepo.getRestProfile();
    res.fold(
      (err) {
        Toast.show(err);
        emit(GetRestProfileError());
      },
      (res) {
        restaurantsModel = res;
        emit(GetRestProfileLoaded());
      },
    );
  }

  Map<int, String> dayMap = {
    0: "السبت",
    1: "الأحد",
    2: "الاتنين",
    3: "الثلاثاء",
    4: "الاربعاء",
    5: "الخميس",
    6: "الجمعه",
  };

  String convertDays(int dayNum) {
    String? day;
    dayMap.forEach((key, value) {
      if (key == dayNum) {
        day = value;
      }
    });
    return day ?? '';
  }

  final List<String> restaurantProfileConstantList = [
    "رقم الهاتف",
    "رقم السجل التجاري",
    "السجيل التجاري",
    "مدير المطعم",
    //"البلد",
    //"المدينه",
    //"الشارع",
    // "رقم البناء"
  ];

  Future<XFile?> getImage() async {
    ImagePicker picker = ImagePicker();
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      return result;
    }
  }

  onLocationClick(context) async {
    var _loc = await Utils.getCurrentLocation(context);
    locationCubit.onLocationUpdated(LocationModel(
      lat: _loc?.latitude ?? 32.4,
      lng: _loc?.longitude ?? 32.4,
      address: "",
    ));
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) {
          return FadeTransition(
              opacity: animation,
              child: BlocProvider.value(
                value: locationCubit,
                child: LocationAddress(),
              ));
        },
      ),
    );
  }
}
