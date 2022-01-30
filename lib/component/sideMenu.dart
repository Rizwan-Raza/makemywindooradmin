import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/style/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                width: double.infinity,
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 35,
                  height: 20,
                  child: SvgPicture.asset('assets/imgs/mac-action.svg'),
                ),
              ),
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  icon: SvgPicture.asset(
                    'assets/imgs/home.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    navigateToFunSideMenu(context, 'dashboard');
                  }),
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  icon: Image.asset(
                    'assets/imgs/create_product.png',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    navigateToFunSideMenu(context, 'create-product');
                  }),
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  icon: Image.asset(
                    'assets/imgs/my_products.png',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    navigateToFunSideMenu(context, 'my-products');
                  }),
              IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  icon: Image.asset(
                    'assets/imgs/orders.png',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {
                    navigateToFunSideMenu(context, 'orders');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  navigateToFunSideMenu(BuildContext context, String routeName) {
    log(ModalRoute.of(context)!.settings.name.toString());
    if (ModalRoute.of(context)!.settings.name.toString() != ("/" + routeName)) {
      Navigator.pushReplacementNamed(context, "/" + routeName);
    }
  }
}
