import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_appbar.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';

import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../generated/l10n.dart';

class MyOrderRestaurantView extends StatefulWidget {
  const MyOrderRestaurantView({Key? key}) : super(key: key);

  @override
  State<MyOrderRestaurantView> createState() => _MyOrderRestaurantViewState();
}

class _MyOrderRestaurantViewState extends State<MyOrderRestaurantView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int tabbed = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: Translation.of(context).my_orders,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 1;
                          tabController!.animateTo(0);
                        });
                      },
                      child: Container(
                          decoration: tabbed == 1
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.5)),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(colors: [
                                    AppColors.transparent.withOpacity(0.3),
                                    AppColors.transparent.withOpacity(0),
                                  ]))
                              : null,
                          child: Center(
                            child: CustomText(
                              text: "قيد الأنتظار",
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 2;
                          tabController!.animateTo(1);
                        });
                      },
                      child: Container(
                          decoration: tabbed == 2
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.5)),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(colors: [
                                    AppColors.transparent.withOpacity(0.3),
                                    AppColors.transparent.withOpacity(0),
                                  ]))
                              : null,
                          child: Center(
                            child: CustomText(
                              text: "الموافق عليها",
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          tabbed = 3;
                          tabController!.animateTo(2);
                        });
                      },
                      child: Container(
                          decoration: tabbed == 3
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(0.5)),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(colors: [
                                    AppColors.transparent.withOpacity(0.3),
                                    AppColors.transparent.withOpacity(0),
                                  ]))
                              : null,
                          child: Center(
                            child: CustomText(
                              text: "الملغاه",
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConstants.textSize16,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const <Widget>[
                WaitingList(),
                AcceptedList(),
                RefusedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingList extends StatelessWidget {
  const WaitingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: false),
            );
          }),
    );
  }
}

class AcceptedList extends StatelessWidget {
  const AcceptedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: true),
            );
          }),
    );
  }
}

class RefusedList extends StatelessWidget {
  const RefusedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CardDetails(selectedCard: true),
            );
          }),
    );
  }
}

class ImageWithNameTrainee extends StatelessWidget {
  const ImageWithNameTrainee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
        image: const DecorationImage(
          image: AssetImage(AppConstants.PLATE_IMG),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 35.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlurWidget(
                height: 100.h,
                child: Center(
                  child: CustomText(
                    text: "طبق شوفان ومكسرات",
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                    fontSize: AppConstants.textSize14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetails extends StatelessWidget {
  final bool selectedCard;

  const CardDetails({Key? key, required this.selectedCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(colors: [
            AppColors.transparent.withOpacity(1),
            AppColors.transparent.withOpacity(0),
          ]),
          border: Border.all(color: AppColors.transparent.withOpacity(0.1))),
      height: 151.h,
      child: Row(
        children: [
          Expanded(
            flex: 3,
              child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                      backgroundImage: AssetImage(AppConstants.COACH4_IMAGE)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "مصطفي محمد",
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      CustomText(
                        text: "عدد :",
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentColorLight,
                      ),
                      Gaps.hGap4,
                      CustomText(
                        text: "4",
                        fontSize: AppConstants.textSize14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText(
                    text: "100 ريال سعودي",
                    color: AppColors.accentColorLight,
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.textSize14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText(
                    text: "#123456",
                    fontSize: AppConstants.textSize14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                selectedCard
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.green,
                              child: Icon(
                                FontAwesomeIcons.check,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Gaps.hGap12,
                          InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.red,
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          )),
          const Expanded(
              flex: 2,
              child: ImageWithNameTrainee())
        ],
      ),
    );
  }
}
