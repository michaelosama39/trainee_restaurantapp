import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/l10n.dart';
import '../../common/app_colors.dart';
import '../../common/style/gaps.dart';
import '../../constants/app/app_constants.dart';
import 'blur_widget.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class HomeAppbar extends StatelessWidget with PreferredSizeWidget {
  final TextEditingController controller;

  const HomeAppbar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      shadowColor: AppColors.transparent,
      title: Padding(
        padding: EdgeInsetsDirectional.only(start: 4.w),
        child: SizedBox(
          width: 1.sw,
          height: 32.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: BlurWidget(
                  borderRadius: AppConstants.borderRadius4,
                ),
              ),
              SearchTextField(
                hintText: Translation.of(context).search,
                controller: controller,
              )
            ],
          ),
        ),
      ),
      actions: [const Icon(Icons.notifications), Gaps.hGap16],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color? color;
  final String title;
  final List<Widget>? actions;

  const TransparentAppBar(
      {Key? key, required this.title, this.actions, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? AppColors.transparent,
      shadowColor: AppColors.transparent,
      elevation: 0,
      title: CustomText(
        text: title,
        fontSize: AppConstants.textSize18,
        fontWeight: FontWeight.bold,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
