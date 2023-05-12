import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/dimens.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/ui/widgets/custom_appbar.dart';
import '../../../../core/ui/widgets/custom_button.dart';
import '../../../../core/ui/widgets/custom_text.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/profile_details/presentation/view/map_edit_user_profile.dart';

class EditRestaurantScreenContent extends StatefulWidget {
  @override
  State<EditRestaurantScreenContent> createState() =>
      _EditRestaurantScreenContentState();
}

class _EditRestaurantScreenContentState
    extends State<EditRestaurantScreenContent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  uploadSignUpFile({required void Function()? onTap, required String text}) {
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
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.upload,
                      color: AppColors.accentColorLight,
                      size: Dimens.dp40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).edit_profile,
      ),
      body: SizedBox(
        height: 1.sh,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                _buildImageWidget(),
                SizedBox(
                  height: 55.h,
                ),
                _buildTextFiledWidget(
                    title: "أسم المطعم باللغه العربيه",
                    textEditingController: nameController),
                Gaps.vGap24,
                _buildTextFiledWidget(
                    title: "أسم المطعم باللغه الانجيليزيه",
                    textEditingController: nameController),
                Gaps.vGap24,
                uploadSignUpFile(text: "لوغو المطعم بالعربي", onTap: () {}),
                Gaps.vGap8,
                uploadSignUpFile(text: "لوغو المطعم بالأنجليزي", onTap: () {}),
                Gaps.vGap8,
                uploadSignUpFile(text: "صورة الغلاف بالأنجليزي", onTap: () {}),
                Gaps.vGap8,
                uploadSignUpFile(text: "صورة الغلاف بالعربي", onTap: () {}),
                _buildTextFiledWidget(
                    title: Translation.of(context).phone,
                    isPhoneNumber: true,
                    textEditingController: phoneController),
                Gaps.vGap24,
                _buildTextFiledWidget(
                    title: "رقم السجل التجاري",
                    textEditingController: weightController),
                Gaps.vGap24,
                uploadSignUpFile(text: "ملف السجل التجاري", onTap: () {}),
                Gaps.vGap8,
                _buildTextFiledWidget(
                    title: Translation.of(context).cityName,
                    textEditingController: heightController),
                Gaps.vGap24,
                _buildTextFiledWidget(
                    title: "اسم الشارع",
                    textEditingController: heightController),
                Gaps.vGap24,
                _buildTextFiledWidget(
                    title: "رقم البناء",
                    textEditingController: heightController),
                Gaps.vGap24,
                _buildTextFiledWidget(
                    title: "اسم مدير المطعم",
                    textEditingController: heightController),
                Gaps.vGap24,
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final LatLng position = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
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
                      //  sn.profileCubit.updateProfile();
                      Nav.pop();
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
      ),
    );
  }

  Widget _buildSocialMediaContainer(
      {required String title, required IconData icon}) {
    return Container(
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          Gaps.hGap8,
          Flexible(
            child: _buildTextFiledWidget(
                title: title, textEditingController: nameController),
          )
        ],
      ),
    );
  }

  late final XFile? image;

  Widget _buildImageWidget() {
    return Container(
      height: 0.52.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
        // image: DecorationImage(
        //     image: FileImage(
        //        image != null ? File(image!.path) :
        //       File(''),
        //     ),
        //     fit: BoxFit.cover),
      ),
      child: Container(
        color: AppColors.primaryColorLight.withOpacity(0.7),
        child: Center(
          child: GestureDetector(
            onTap: () async {
              // ImagePicker _picker = ImagePicker();
              // var _image = await _picker.pickImage(source: ImageSource.camera);
              // setState(() {
              //   image = _image;
              //   print("img:${_image!.path}");
              //   // profileCubit.updateImage(File(_image.path));
              // });
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
  }

  Widget _buildTextFiledWidget(
      {required String title,
      bool isPhoneNumber = false,
      required TextEditingController textEditingController}) {
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
                    textEditingController: TextEditingController(),
                    onInputChanged: (p0) {},
                  ),
                ),
              )
            : TextFormField(
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

  List<String> weekdays = [
    'الأحد',
    'الاتنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعه',
    'السبت'
  ]; // List of weekdays
  List<bool> selectedDays = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ]; // List to track selected days
  Widget _addWorkingHours() {
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
                    flex: 3,
                    child: SizedBox(
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: selectedDays[index],
                                activeColor: AppColors.accentColorLight,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    selectedDays[index] = newValue!;
                                  });
                                }),
                            CustomText(
                              text: weekdays[index],
                              fontSize: AppConstants.textSize12,
                            ),
                          ],
                        ))),
                Expanded(
                    child: SizedBox(
                  height: 20.h,
                  child: const CustomText(text: "من"),
                )),
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: AppColors.white)),
                      height: 30.h,
                      child: HourDropDown(),
                    )),
                Expanded(
                    child: SizedBox(
                  height: 20.h,
                  child: const CustomText(text: "الي"),
                )),
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
  }
}

class HourDropDown extends StatefulWidget {
  @override
  _HourDropDownState createState() => _HourDropDownState();
}

class _HourDropDownState extends State<HourDropDown> {
  String selectedHour = '1:00 am'; // Default selected hour
  List<String> hoursList = [
    '1:00 am',
    '2:00 am',
    '3:00 am',
    '4:00 am',
    '5:00 am',
    '6:00 am',
    '7:00 am',
    '8:00 am',
    '9:00 am',
    '10:00 am',
    '11:00 am',
    '12:00 am',
    '1:00 pm',
    '2:00 pm',
    '3:00 pm',
    '4:00 pm',
    '5:00 pm',
    '6:00 pm',
    '7:00 pm',
    '8:00 pm',
    '9:00 pm',
    '10:00 pm',
    '11:00 pm',
    '12:00 pm'
  ]; // List of hours

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: DropdownButton<String>(
        value: selectedHour,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.accentColorLight

          ,
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
