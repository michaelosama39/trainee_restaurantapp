import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/restaurant/home_restaurant/view/home_restaurant_view.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/ui/widgets/route_aware_widget.dart';
import '../../../../generated/l10n.dart';
import '../../restaurant/add_plate/view/add_plate_view.dart';
import '../../restaurant/restaurant_profile/view/restaurant_profile.dart';
import '../../trainer/home_trainer/presentation/view/home_trainer_view.dart';
import '../../trainer/more_trainer/view/more_trainer_view.dart';
import '../../trainer/profile_details/presentation/view/profile_view_screen.dart';

class NavigatorScreen extends StatefulWidget {
  static const String routeName = "NavigatorScreen/";
  int homeType;

   NavigatorScreen({Key? key,required this.homeType}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends RouteAwareState<NavigatorScreen> {

  late List<Widget> _pages;

  late PageController _pageController;
  int _selectedPage = 0;
  GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');
  bool _inScreen = true;

  @override
  void initState() {
    super.initState();
    // if (Provider.of<SessionDataProvider>(context, listen: false)
    //         .sharedStoryId !=
    //     null) {
    //   _selectedPage = 2;
    //   _pageController = PageController(initialPage: 2);
    // }
    // else
    _pageController = PageController();
    _pages = widget.homeType==0?[
      const HomeTrainerScreen(),
      Container(),
      ProfileTrainerScreenView(),
      // const ProfileScreen(),
      // const MoreScreen()
      const MoreTrainerScreen()
    ]:widget.homeType==1?[
      const HomeTrainerScreen(),
      Container(),
      // const ProfileScreen(),
      // const MoreScreen()
      const MoreTrainerScreen(),
      ProfileTrainerScreenView(),
    ]:widget.homeType==3?[
      const HomeRestaurantScreen(),
      Container(),
      // const ProfileScreen(),
      // const MoreScreen()
      const RestaurantProfile(),
      const MoreTrainerScreen(),
    ]:[
      Container(),
      ProfileTrainerScreenView(),
      // const ProfileScreen(),
      // const MoreScreen()
      const MoreTrainerScreen(),
      const HomeTrainerScreen(),
    ];

    // DynamicLinkService dynamicLinkService = DynamicLinkService();
    // dynamicLinkService.fetchLinkData(onHandle: (id) {
    //   _onDynamicLinkExists(id);
    // });
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      bottom: 10,
      child: SizedBox(
        width: 1.sw,
        height: 56.h,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColorLight,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConstants.textSize12))),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColors.transparent.withOpacity(0.3),
                            AppColors.transparent.withOpacity(0)
                          ]),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppConstants.textSize12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              _onItemTapped(0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageIcon(
                                    const AssetImage(
                                      AppConstants.HOME_ICON,
                                    ),
                                    color: _selectedPage == 0
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                    size: AppConstants.textSize18.h,
                                  ),
                                  CustomText(
                                    text: Translation.of(context).homePage,
                                    color: _selectedPage == 0
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _onItemTapped(1);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageIcon(
                                    const AssetImage(
                                      AppConstants.MAIL_ICON,
                                    ),
                                    color: _selectedPage == 1
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                    size: AppConstants.textSize18.h,
                                  ),
                                  CustomText(
                                    text: Translation.of(context).mail,
                                    color: _selectedPage == 1
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _onItemTapped(2);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ImageIcon(
                                    const AssetImage(
                                      AppConstants.PROFILE_ICON,
                                    ),
                                    color: _selectedPage == 2
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                    size: AppConstants.textSize18.h,
                                  ),
                                  CustomText(
                                    text: Translation.of(context).profile,
                                    color: _selectedPage == 2
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _onItemTapped(3);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.more_horiz,
                                    color: _selectedPage == 3
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                    size: AppConstants.textSize18.h,
                                  ),
                                  CustomText(
                                    text: Translation.of(context).more,
                                    color: _selectedPage == 3
                                        ? AppColors.accentColorLight
                                        : AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColorLight,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      if(widget.homeType == 3){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlateView()));
                      }else{
                        Navigator.of(context).pushNamed(Routes.addCourseScreen);
                      }
                    },
                    child: Container(
                      width: double.minPositive,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.transparent.withOpacity(0.2)),
                        gradient: LinearGradient(colors: [
                          AppColors.transparent.withOpacity(0.3),
                          AppColors.transparent.withOpacity(0)
                        ]),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.add,
                          color: AppColors.accentColorLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: BottomNavigationBar(
          //   key: globalKey,
          //   currentIndex: _selectedPage,
          //   showUnselectedLabels: true,
          //   elevation: 0.0,
          //   iconSize: 18.w,
          //   selectedLabelStyle: TextStyle(
          //       fontSize: AppConstants.textSize12, fontWeight: FontWeight.bold),
          //   selectedItemColor: AppColors.accentColorLight,
          //   unselectedItemColor: AppColors.blue,
          //   items: [
          //     BottomNavigationBarItem(
          //         icon: Container(
          //           child: Padding(
          //             padding: EdgeInsets.only(bottom: 0.0),
          //             child: ImageIcon(AssetImage(
          //               AppConstants.HOME_ICON,
          //             )),
          //           ),
          //         ),
          //         label: Translation.of(context).homePage),
          //     BottomNavigationBarItem(
          //         icon: Padding(
          //           padding: EdgeInsets.only(bottom: 0.0),
          //           child: ImageIcon(AssetImage(
          //             AppConstants.MAIL_ICON,
          //           )),
          //         ),
          //         label: Translation.of(context).mail),
          //     BottomNavigationBarItem(
          //         icon: Padding(
          //           padding: EdgeInsets.only(bottom: 0.0),
          //           child: ImageIcon(AssetImage(
          //             AppConstants.SEARCH_ICON,
          //           )),
          //         ),
          //         label: Translation.of(context).search),
          //     BottomNavigationBarItem(
          //         icon: const Padding(
          //           padding: EdgeInsets.only(bottom: 0.0),
          //           child: ImageIcon(AssetImage(
          //             AppConstants.PROFILE_ICON,
          //           )),
          //         ),
          //         label: Translation.of(context).profile),
          //     BottomNavigationBarItem(
          //         icon: const Padding(
          //           padding: EdgeInsets.only(bottom: 0.0),
          //           child: Icon(Icons.more_horiz),
          //         ),
          //         label: Translation.of(context).more),
          //   ],
          //   onTap: (value) {
          //     _onItemTapped(value);
          //   },
          // ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    });
  }

  void _onDynamicLinkExists(String? id) {
    //Provider.of<SessionDataProvider>(context, listen: false).sharedStoryId = id;

    if (_inScreen) {
      _onItemTapped(2);
      print('nnnav');
    } else {
      Nav.off(NavigatorScreen.routeName, cleanHistory: true);
      print('nnnot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _selectedPage = value;
                });
              },
              children: _pages,
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onEnterScreen() {
    // TODO: implement onEnterScreen
  }

  @override
  void onLeaveScreen() {
    print('nnnnext');
    setState(() {
      _inScreen = false;
    });
  }
}
