import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/services/auth.dart';
import 'package:provider/provider.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // IconButton(
        //     icon: SvgPicture.asset(
        //       'assets/imgs/calendar.svg',
        //       width: 20,
        //     ),
        //     onPressed: () {}),
        // SizedBox(width: 10),
        // IconButton(
        //     icon: SvgPicture.asset('assets/imgs/ring.svg', width: 20.0),
        //     onPressed: () {}),
        // SizedBox(width: 15),
        ElevatedButton.icon(
          onPressed: () {
            Provider.of<Login>(context, listen: false).logout().then((value) =>
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false));
          },
          icon: Icon(LineIcons.alternateSignOut),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('Logout'),
          ),
        ),

        SizedBox(width: 16),
        Row(children: [
          CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2013/07/12/12/32/airplane-145889_960_720.png',
            ),
          ),
          // Icon(Icons.arrow_drop_down_outlined, color: AppColors.black)
        ]),
      ],
    );
  }
}
