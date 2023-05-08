import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../core/ui/widgets/custom_appbar.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  horizontalListView() {
    return Container(
      height: 120.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      image: AssetImage(
                        AppConstants.TRAINEE_IMG,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        text: "رامي المصرى",
                        fontWeight: FontWeight.w700,
                        fontSize: AppConstants.textSize10),
                    CustomText(
                      text: "متدرب كورس أثقال",
                      fontWeight: FontWeight.w700,
                      fontSize: AppConstants.textSize10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  verticalListView() {
    return Expanded(
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90.h,
                  child: Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 95.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.h),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppConstants.TRAINEE_IMG,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomText(
                                text: "رامي المصري",
                                fontSize: AppConstants.textSize18,
                                fontWeight: FontWeight.w600,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        text: "اريد السؤال عن كورس الاثقال",
                                        textOverflow: TextOverflow.ellipsis,
                                        fontSize: AppConstants.textSize14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    text: "10/3/2022",
                                    fontSize: AppConstants.textSize14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: AppColors.white,
              );
            },
            itemCount: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: "تبي تواصل معا متدربك؟",
      ),
      body: Column(
        children: [
          horizontalListView(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppColors.white,
            ),
          ),
          verticalListView()
        ],
      ),
    );
  }
}
