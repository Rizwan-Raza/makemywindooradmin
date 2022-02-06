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
        // ElevatedButton.icon(
        //   onPressed: () {
        //     Provider.of<Login>(context, listen: false).logout().then((value) =>
        //         Navigator.of(context).pushNamedAndRemoveUntil(
        //             '/', (Route<dynamic> route) => false));
        //   },
        //   icon: Icon(LineIcons.alternateSignOut),
        //   label: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 12),
        //     child: Text('Logout'),
        //   ),
        // ),

        // SizedBox(width: 16),
        // Row(children: [
        //   CircleAvatar(
        //     radius: 17,
        //     backgroundImage: AssetImage(
        //       "assets/imgs/man.jpeg",
        //     ),
        //   ),
        //   SizedBox(width: 8),
        //   Text(Provider.of<Login>(context).userData['username']),
        //   SizedBox(width: 8),
        //   // Icon(LineIcons.angleDown, color: Colors.black)
        // ]),
        PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                CircleAvatar(
                  radius: 17,
                  backgroundImage: AssetImage(
                    "assets/imgs/man.jpeg",
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  Provider.of<Login>(context).userData['username'],
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 8),
                Icon(LineIcons.angleDown, color: Colors.black)
              ]),
            ),
            // icon: Icon(LineIcons.angleDown),
            onSelected: (value) {
              switch (value) {
                case 1:
                  showDialog(
                      context: context,
                      builder: (iContext) {
                        TextEditingController _newPassword =
                            TextEditingController();
                        return AlertDialog(
                          title: Text("Change Password"),
                          content: TextField(
                            controller: _newPassword,
                            decoration: InputDecoration(
                              labelText: "New Password",
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () => Navigator.of(iContext).pop(),
                            ),
                            ElevatedButton(
                              child: Text("Change"),
                              onPressed: () {
                                if (_newPassword.text.isEmpty) return;
                                Navigator.of(iContext).pop();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (childContext) {
                                      return AlertDialog(
                                        title: Text('Changing password'),
                                        content: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('Please wait'),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                Provider.of<Login>(context, listen: false)
                                    .changePassword(_newPassword.text)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (childContext) {
                                        return AlertDialog(
                                          title: Text('Password changed'),
                                          content: Text(
                                              'Your password has been changed'),
                                          actions: [
                                            TextButton(
                                              child: Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(childContext)
                                                    .pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                });
                              },
                            ),
                          ],
                        );
                      });
                  break;
                case 2:
                  Provider.of<Login>(context, listen: false).logout().then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false));
                  break;
              }
            },
            itemBuilder: (iContext) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(LineIcons.lock),
                        SizedBox(width: 8),
                        Text("Change Password"),
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(LineIcons.alternateSignOut),
                        SizedBox(width: 8),
                        Text("Logout"),
                      ],
                    ),
                    value: 2,
                  )
                ])
      ],
    );
  }
}
