import 'package:flutter/material.dart';
import 'package:makemywindoor_admin/config/size_config.dart';

class TodayOrders extends StatelessWidget {
  const TodayOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: SizeConfig.blockSizeVertical! * 10,
            child: Card(
              color: Colors.amber,
              margin: EdgeInsets.all(10),
              shadowColor: Colors.black,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('order' + index.toString()), Text('date')],
              ),
            ),
          );
        });
  }
}
