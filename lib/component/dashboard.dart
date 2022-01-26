import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makemywindoor_admin/component/header.dart';
import 'package:makemywindoor_admin/component/infoCard.dart';
import 'package:makemywindoor_admin/component/todayOrders.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/home.dart';
import 'package:makemywindoor_admin/services/project_service.dart';
import 'package:makemywindoor_admin/style/colors.dart';
import 'package:makemywindoor_admin/style/style.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Home(
      Expanded(
        flex: 10,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 4,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      InfoCard(
                          icon: 'assets/imgs/create_product.png',
                          label: 'Create Products',
                          amount: '\1200',
                          onpressedFun: () {
                            navigateToFun(context, 'createProduct');
                          }),
                      InfoCard(
                          icon: 'assets/imgs/my_products.png',
                          label: 'My Products',
                          amount: '\1500',
                          onpressedFun: () {
                            navigateToFun(context, 'myProducts');
                          }),
                      InfoCard(
                          icon: 'assets/imgs/orders.png',
                          label: 'Customer Orders',
                          amount: '\150',
                          onpressedFun: () {
                            navigateToFun(context, 'orders');
                          }),
                      // InfoCard(
                      //     icon: 'assets/imgs/orders.png',
                      //     label: 'Others',
                      //     amount: '\1500',
                      //     onpressedFun: () {
                      //       navigateToFun(context, 'orders');
                      //     }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryText(
                          text: 'Today Orders',
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: Provider.of<ProjectServices>(context)
                                .getTodaysProjects(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return PrimaryText(
                                    text: snapshot.data!.docs.length.toString(),
                                    size: 30,
                                    fontWeight: FontWeight.w800);
                              else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ],
                    ),
                    // PrimaryText(
                    //   text: 'Past 30 DAYS',
                    //   size: 16,
                    //   fontWeight: FontWeight.w400,
                    //   color: AppColors.secondary,
                    // ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 3,
                ),

                TodayOrders(),

                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 5,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     PrimaryText(
                //         text: 'History', size: 30, fontWeight: FontWeight.w800),
                //     PrimaryText(
                //       text: 'Transaction of lat 6 month',
                //       size: 16,
                //       fontWeight: FontWeight.w400,
                //       color: AppColors.secondary,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: SizeConfig.blockSizeVertical! * 3,
                // ),
                // HistoryTable(),
                // if (!Responsive.isDesktop(context)) PaymentDetailList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToFun(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, "/" + routeName);
  }
}
