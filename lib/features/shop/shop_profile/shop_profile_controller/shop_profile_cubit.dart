import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:trainee_restaurantapp/features/shop/shop_profile/data/models/update_shop_profile_model.dart';
import '../../../../core/ui/toast.dart';
import '../../../navigator_home/view/navigator_home_view.dart';
import '../../../../core/models/shop_model.dart';
import '../data/repositories/ShopProfileRepo.dart';

part 'shop_profile_state.dart';

class ShopProfileCubit extends Cubit<ShopProfileState> {
  ShopProfileCubit() : super(ShopProfileInitial());

  static ShopProfileCubit of(context) => BlocProvider.of(context);

  final shopProfileRepo = ShopProfileRepo();

  ShopModel? shopModel;

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

  Future uploadImage(BuildContext context, File file) async {
    emit(UploadImageLoading());
    final res = await shopProfileRepo.uploadImage(file);
    res.fold(
      (err) {
        Toast.show(err);
        emit(ShopProfileInitial());
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

  Future updateShopProfile(BuildContext context) async {
    UpdateShopProfileModel updateShopProfileModel = UpdateShopProfileModel(
      id: shopModel!.id,
      arName: nameArController.text,
      enName: nameEnController.text,
      arLogo: imgLogoAr,
      enLogo: imgLogoEn,
      arCover: imgCoveAr,
      enCover: imgCoveEn,
      commercialRegisterNumber: commercialRegisterNumberController.text,
      commercialRegisterDocument: imgCommercialRegisterDoc,
      cityId: shopModel!.cityId,
      street: shopModel!.street,
      // buildingNumber: int.parse(shopModel!.buildingNumber ?? ''),
      phoneNumber: phoneController.text,
      facebookUrl: facebookController.text,
      instagramUrl: instegramController.text,
      twitterUrl: twitterController.text,
      websiteUrl: websiteController.text,
    );

    emit(UpdateShopProfileLoading());
    final res = await shopProfileRepo.updateShopProfile(updateShopProfileModel);
    res.fold(
      (err) {
        Toast.show(err);
        print(err);
        emit(UpdateShopProfileError());
      },
      (res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavigatorScreen(homeType: 4)),
            (route) => false);
        emit(UpdateShopProfileLoaded());
      },
    );
  }

  Future getShopProfile(BuildContext context) async {
    emit(GetShopProfileLoading());
    final res = await shopProfileRepo.getShopProfile();
    res.fold(
      (err) {
        Toast.show(err);
        emit(GetShopProfileError());
      },
      (res) {
        shopModel = res;
        res.openingDays!.forEach((element) {
          print(element.day);
          print(DateFormat('HH:mm').format(DateTime.parse(element.from ?? '')));
          print(DateFormat('HH:mm').format(DateTime.parse(element.to ?? '')));
          print("----------------------------");
        });
        emit(GetShopProfileLoaded());
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
    // "البلد",
    // "المدينه",
    // "الشارع",
    // "رقم البناء"
  ];

  Future<XFile?> getImage() async {
    ImagePicker picker = ImagePicker();
    var result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      return result;
    }
  }
}
