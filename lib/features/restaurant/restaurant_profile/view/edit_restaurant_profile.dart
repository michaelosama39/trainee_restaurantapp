import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/dimens.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/ui/loader.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/profile_details/presentation/view/map_edit_user_profile.dart';
import '../data/models/restaurants_model.dart';
import '../rest_profile_controller/rest_profile_cubit.dart';

class EditRestaurantScreenContent extends StatefulWidget {
  @override
  State<EditRestaurantScreenContent> createState() =>
      _EditRestaurantScreenContentState();
}

class _EditRestaurantScreenContentState
    extends State<EditRestaurantScreenContent> {
  @override
  void initState() {
    RestProfileCubit.of(context).getRestaurantProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).edit_profile,
      ),
      body: BlocConsumer<RestProfileCubit, RestProfileState>(
        listener: (context, state) {
          RestProfileCubit.of(context).imageNetwork =
              RestProfileCubit.of(context).restaurantsModel!.logo;
          RestProfileCubit.of(context).nameArController.text =
              RestProfileCubit.of(context).restaurantsModel!.arName ?? '';
          RestProfileCubit.of(context).nameEnController.text =
              RestProfileCubit.of(context).restaurantsModel!.enName ?? '';
          RestProfileCubit.of(context).logoArNetwork =
              RestProfileCubit.of(context).restaurantsModel!.arLogo ?? '';
          RestProfileCubit.of(context).logoEnNetwork =
              RestProfileCubit.of(context).restaurantsModel!.enLogo ?? '';
          RestProfileCubit.of(context).coveArNetwork =
              RestProfileCubit.of(context).restaurantsModel!.arCover ?? '';
          RestProfileCubit.of(context).coveEnNetwork =
              RestProfileCubit.of(context).restaurantsModel!.enCover ?? '';
          RestProfileCubit.of(context).phoneController.text =
              RestProfileCubit.of(context).restaurantsModel!.phoneNumber ?? '';
          RestProfileCubit.of(context).commercialRegisterNumberController.text =
              RestProfileCubit.of(context)
                      .restaurantsModel!
                      .commercialRegisterNumber ??
                  '';
          RestProfileCubit.of(context).commercialRegisterDoc =
              RestProfileCubit.of(context)
                      .restaurantsModel!
                      .commercialRegisterDocument ??
                  '';
          RestProfileCubit.of(context).cityController.text =
              RestProfileCubit.of(context).restaurantsModel!.city!.text ?? '';
          RestProfileCubit.of(context).streetController.text =
              RestProfileCubit.of(context).restaurantsModel!.street ?? '';
          RestProfileCubit.of(context).buildNumController.text =
              RestProfileCubit.of(context).restaurantsModel!.buildingNumber ??
                  '';
          RestProfileCubit.of(context).mangerController.text =
              RestProfileCubit.of(context).restaurantsModel!.manager!.name ??
                  '';
          RestProfileCubit.of(context).facebookController.text =
              RestProfileCubit.of(context).restaurantsModel!.facebookUrl ?? '';
          RestProfileCubit.of(context).instegramController.text =
              RestProfileCubit.of(context).restaurantsModel!.instagramUrl ?? '';
          RestProfileCubit.of(context).twitterController.text =
              RestProfileCubit.of(context).restaurantsModel!.twitterUrl ?? '';
          RestProfileCubit.of(context).websiteController.text =
              RestProfileCubit.of(context).restaurantsModel!.websiteUrl ?? '';
        },
        builder: (context, state) {
          if (state is GetRestProfileLoading) {
            return const Loader();
          } else {
            return SizedBox(
              height: 1.sh,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      _buildImageWidget(
                          RestProfileCubit.of(context).file ?? File('')),
                      SizedBox(
                        height: 55.h,
                      ),
                      _buildTextFiledWidget(
                          title: "أسم المطعم باللغه العربيه",
                          textEditingController:
                              RestProfileCubit.of(context).nameArController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: "أسم المطعم باللغه الانجيليزيه",
                          textEditingController:
                              RestProfileCubit.of(context).nameEnController),
                      Gaps.vGap24,
                      uploadSignUpFile(
                        text: "لوغو المطعم بالعربي",
                        file:
                            RestProfileCubit.of(context).fileLogoAr ?? File(''),
                        image: RestProfileCubit.of(context).logoArNetwork ?? '',
                        onTap: () async {
                          await RestProfileCubit.of(context).getImage();
                          RestProfileCubit.of(context).emit(GetImageState());
                        },
                      ),
                      Gaps.vGap8,
                      uploadSignUpFile(
                        text: "لوغو المطعم بالأنجليزي",
                        file:
                            RestProfileCubit.of(context).fileLogoEn ?? File(''),
                        image: RestProfileCubit.of(context).logoEnNetwork ?? '',
                        onTap: () async {
                          await RestProfileCubit.of(context).getImage();
                          RestProfileCubit.of(context).emit(GetImageState());
                        },
                      ),
                      Gaps.vGap8,
                      uploadSignUpFile(
                        text: "صورة الغلاف بالأنجليزي",
                        file:
                            RestProfileCubit.of(context).fileCoveEn ?? File(''),
                        image: RestProfileCubit.of(context).coveEnNetwork ?? '',
                        onTap: () async {
                          await RestProfileCubit.of(context).getImage();
                          RestProfileCubit.of(context).emit(GetImageState());
                        },
                      ),
                      Gaps.vGap8,
                      uploadSignUpFile(
                        text: "صورة الغلاف بالعربي",
                        file:
                            RestProfileCubit.of(context).fileCoveAr ?? File(''),
                        image: RestProfileCubit.of(context).coveArNetwork ?? '',
                        onTap: () async {
                          await RestProfileCubit.of(context).getImage();
                          RestProfileCubit.of(context).emit(GetImageState());
                        },
                      ),
                      _buildTextFiledWidget(
                          title: Translation.of(context).phone,
                          isPhoneNumber: true,
                          textEditingController:
                              RestProfileCubit.of(context).phoneController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: "رقم السجل التجاري",
                          textEditingController: RestProfileCubit.of(context)
                              .commercialRegisterNumberController),
                      Gaps.vGap24,
                      uploadSignUpFile(
                        text: "ملف السجل التجاري",
                        file: RestProfileCubit.of(context)
                                .fileCommercialRegisterDoc ??
                            File(''),
                        image: RestProfileCubit.of(context)
                                .commercialRegisterDoc ??
                            '',
                        onTap: () async {
                          await RestProfileCubit.of(context).getImage();
                          RestProfileCubit.of(context).emit(GetImageState());
                        },
                      ),
                      Gaps.vGap8,
                      _buildTextFiledWidget(
                          title: Translation.of(context).cityName,
                          textEditingController:
                              RestProfileCubit.of(context).cityController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: "اسم الشارع",
                          textEditingController:
                              RestProfileCubit.of(context).streetController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: "رقم البناء",
                          textEditingController:
                              RestProfileCubit.of(context).buildNumController),
                      Gaps.vGap24,
                      _buildTextFiledWidget(
                          title: "اسم مدير المطعم",
                          textEditingController:
                              RestProfileCubit.of(context).mangerController),
                      Gaps.vGap24,
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final LatLng position = await Navigator.push(
                                  context, MaterialPageRoute(builder: (_) {
                                return MapScreen();
                              }));
                              print("pos:${position.latitude}");
                            },
                            child: CustomText(
                              text: "حدد موقعك علي الخريطه ",
                              color: AppColors.accentColorLight,
                              fontSize: AppConstants.textSize16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap8,
                      _buildSocialMediaContainer(
                          title: "روابط مواقع التواصل الاجتماعي",
                          icon: FontAwesomeIcons.squareFacebook),
                      _buildSocialMediaContainer(
                          title: "", icon: FontAwesomeIcons.instagram),
                      _buildSocialMediaContainer(
                          title: "", icon: FontAwesomeIcons.twitter),
                      _buildSocialMediaContainer(
                          title: "", icon: FontAwesomeIcons.earth),
                      Gaps.vGap24,
                      _addWorkingHours(),
                      Gaps.vGap24,
                      SizedBox(
                        height: 44.h,
                        width: 217.w,
                        child: CustomElevatedButton(
                          text: Translation.of(context).save,
                          onTap: () {
                            RestProfileCubit.of(context)
                                .updateRestaurantProfile(context);
                          },
                          textSize: AppConstants.textSize20,
                          borderRadius: AppConstants.borderRadius4,
                        ),
                      ),
                      Gaps.vGap24,
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  uploadSignUpFile({
    required void Function()? onTap,
    required String text,
    required File file,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              CustomText(
                  text: text,
                  fontSize: AppConstants.textSize18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentColorLight),
              Gaps.hGap12,
              DottedBorder(
                color: AppColors.white,
                dashPattern: const [5, 3],
                radius: const Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: file.path.isNotEmpty
                      ? Image.file(file)
                      : Image.network(image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaContainer(
      {required String title, required IconData icon}) {
    return Row(
      // textDirection: TextDirection.LTR,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: _buildTextFiledWidget(
              title: title,
              textEditingController:
              RestProfileCubit.of(context).facebookController),
        ),
        Gaps.hGap8,
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Icon(
                  icon,
                  color: AppColors.accentColorLight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageWidget(File file) {
    return BlocBuilder<RestProfileCubit, RestProfileState>(
      buildWhen: (previous, current) => current is GetImageState,
      builder: (context, state) {
        return Container(
          height: 0.52.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
            image: file.path.isEmpty
                ? DecorationImage(
                    image: NetworkImage(
                        RestProfileCubit.of(context).imageNetwork ?? ''),
                    fit: BoxFit.cover)
                : DecorationImage(
                    image: FileImage(File(file.path)), fit: BoxFit.cover),
          ),
          child: Container(
            color: AppColors.primaryColorLight.withOpacity(0.7),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  await RestProfileCubit.of(context).getImage();
                  RestProfileCubit.of(context).emit(GetImageState());
                },
                child: ImageIcon(
                  const AssetImage(AppConstants.CAMERA_ICON),
                  color: AppColors.white,
                  size: 104.w,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFiledWidget({
    required String title,
    bool isPhoneNumber = false,
    required TextEditingController textEditingController,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: AppConstants.textSize16,
        ),
        Gaps.vGap4,
        isPhoneNumber
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.white,
                    ),
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius6)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: PhoneNumberTextField(
                    border: InputBorder.none,
                    hint: "",
                    textEditingController: textEditingController,
                    onInputChanged: (p0) {},
                  ),
                ),
              )
            : TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColors.white,
                  )),
                ),
              ),
      ],
    );
  }

  static String getDay(int dayNum) {
    String? day;
    days.forEach((key, value) {
      if (dayNum == key) {
        day = value;
      }
    });
    return day ?? '';
  }

  static Map<int, String> days = {
    0: 'الأحد',
    1: 'الاتنين',
    2: 'الثلاثاء',
    3: 'الأربعاء',
    4: 'الخميس',
    5: 'الجمعه',
    6: 'السبت',
  };

  List<Weekdays> weekdaysList = [
    Weekdays(id: 0, day: getDay(0), selectedDays: false),
    Weekdays(id: 1, day: getDay(1), selectedDays: false),
    Weekdays(id: 2, day: getDay(2), selectedDays: false),
    Weekdays(id: 3, day: getDay(3), selectedDays: false),
    Weekdays(id: 4, day: getDay(4), selectedDays: false),
    Weekdays(id: 5, day: getDay(5), selectedDays: false),
    Weekdays(id: 6, day: getDay(6), selectedDays: false)
  ];

  String formattedTime(String dateTime) {
    return DateFormat('hh:mm a').format(DateTime.parse(dateTime));
  }

  Widget _addWorkingHours() {
    return BlocBuilder<RestProfileCubit, RestProfileState>(
      builder: (context, state) {
        List<OpeningDays> openingDays =
            RestProfileCubit.of(context).restaurantsModel!.openingDays ?? [];
        weekdaysList.forEach((element) {
          openingDays.forEach((elementOpeningDays) {
            if (element.id == elementOpeningDays.day) {
              element.selectedDays = true;
              print(formattedTime(elementOpeningDays.from??''));
              print(formattedTime(elementOpeningDays.to??''));
            }
          });
        });
        return SizedBox(
          height: 350.h,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: weekdaysList[index].selectedDays,
                              activeColor: AppColors.accentColorLight,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  weekdaysList[index].selectedDays = newValue!;
                                });
                              },
                            ),
                            CustomText(
                              text: weekdaysList[index].day ?? '',
                              fontSize: AppConstants.textSize12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20.h,
                        child: const CustomText(text: "من"),
                      ),
                    ),
                    Gaps.hGap4,
                    Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: AppColors.white),
                          ),
                          height: 30.h,
                          child: HourDropDown(),
                        )),
                    Gaps.hGap4,
                    Expanded(
                      child: SizedBox(
                        height: 20.h,
                        child: const CustomText(text: "الي"),
                      ),
                    ),
                    Gaps.hGap4,
                    Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: AppColors.white)),
                          height: 30.h,
                          child: HourDropDown(),
                        )),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class HourDropDown extends StatefulWidget {
  @override
  _HourDropDownState createState() => _HourDropDownState();
}

class _HourDropDownState extends State<HourDropDown> {
  String selectedHour = '01:00 AM'; // Default selected hour
  List<String> hoursList = [
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM'
  ]; // List of hours

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: DropdownButton<String>(
        value: selectedHour,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.accentColorLight,
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedHour = newValue!;
          });
        },
        items: hoursList.map<DropdownMenuItem<String>>((String hour) {
          return DropdownMenuItem<String>(
            value: hour,
            child: CustomText(
                text: hour,
                color: AppColors.accentColorLight,
                fontSize: AppConstants.textSize12),
          );
        }).toList(),
        underline: Container(),
        isExpanded: true,
      ),
    );
  }
}

class Weekdays {
  String? day;
  int? id;
  bool? selectedDays;

  Weekdays({required this.day, required this.id, required this.selectedDays});
}
