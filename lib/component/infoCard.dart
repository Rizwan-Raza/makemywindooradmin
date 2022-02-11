import 'package:flutter/material.dart';
import 'package:makemywindoor_admin/config/responsive.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/style/colors.dart';
import 'package:makemywindoor_admin/style/style.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;
  final Function onpressedFun;

  InfoCard(
      {required this.icon,
      required this.label,
      required this.amount,
      required this.onpressedFun});

  @override
  Widget build(BuildContext context) {
    // Type type = (SizeConfig.screenWidth! > 640 ? Row : Column);
    return GestureDetector(
      onTap: () {
        onpressedFun();
      },
      child: Container(
        width: SizeConfig.screenWidth! / 6,
        constraints: BoxConstraints(
            minWidth: Responsive.isDesktop(context)
                ? 200
                : SizeConfig.screenWidth! / 2 - 40),
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Column(
          // direction:
          //     (SizeConfig.screenWidth! < 640 ? Axis.horizontal : Axis.vertical),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: 50),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 2,
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            PrimaryText(text: label, color: AppColors.secondary, size: 16),
            // SizedBox(
            //   height: SizeConfig.blockSizeVertical! * 2,
            // ),
            // PrimaryText(
            //   text: amount,
            //   size: 18,
            //   fontWeight: FontWeight.w700,
            // )
          ],
        ),
      ),
    );
  }
}
