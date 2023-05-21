import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/shop/my_products/view/all_products_screen.dart';
import '../../../../core/common/app_colors.dart';

class SuccessProductAdd extends StatelessWidget {
  const SuccessProductAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey2.withOpacity(0.5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      endRadius: 100.0,
                      glowColor: AppColors.white,
                      child: Material(
                        // Replace this child with your own
                        elevation: 8.0,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 50.0,
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            size: 50,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    CustomText(
                      text: "تمت اضافة منتجك بنجاح",
                      color: AppColors.white,
                      fontSize: AppConstants.textSize18,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                )),
            Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  child: NewElevatedButton(
                    color: null,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const AllProductsScreen()));
                    },
                    text: "الذهاب الي منتجاتي",
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
