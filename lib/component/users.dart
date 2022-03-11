import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/home.dart';
import 'package:makemywindoor_admin/model/user.dart';
import 'package:makemywindoor_admin/services/auth.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Home(
      Expanded(
        flex: 10,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: context.read<Login>().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                      dataRowHeight: 72,
                      columns: [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Company')),
                        // DataColumn(label: Text('Active')),
                        // DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Actions'))
                      ],
                      rows: snapshot.data!.docs.map((e) {
                        User u = User.fromMap(e.data());
                        return DataRow(
                            color: (u.disabled ?? false)
                                ? MaterialStateProperty.all(Colors.red[50])
                                : null,
                            cells: [
                              DataCell(SelectableText(u.name)),
                              DataCell(SelectableText(u.email)),
                              DataCell(SelectableText(
                                u.phone,
                                maxLines: 1,
                              )),
                              DataCell(SelectableText(u.company ?? "NA")),
                              // DataCell(
                              //   DropdownButtonFormField<String>(
                              //       decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           fillColor: Colors.grey[300],
                              //           filled: true),
                              //       items: [
                              //         DropdownMenuItem(
                              //           child: Text('Enabled'),
                              //           value: 'Enabled',
                              //         ),
                              //         DropdownMenuItem(
                              //           child: Text('Disabled'),
                              //           value: 'Disabled',
                              //         ),
                              //       ],
                              //       value: (u.disabled ?? false)
                              //           ? 'Disabled'
                              //           : 'Enabled',
                              //       icon: Icon(LineIcons.angleDown),
                              //       onChanged: (value) {
                              //         showDialog(
                              //             context: context,
                              //             builder: (parentContext) {
                              //               return AlertDialog(
                              //                 title: Text('Are you sure?'),
                              //                 content: Text(
                              //                     'Do you want to change the status of this user to $value?'),
                              //                 actions: [
                              //                   TextButton(
                              //                     child: Text('Cancel'),
                              //                     onPressed: () {
                              //                       Navigator.of(parentContext)
                              //                           .pop();
                              //                     },
                              //                   ),
                              //                   TextButton(
                              //                     child: Text('Ok'),
                              //                     onPressed: () {
                              //                       Navigator.of(parentContext)
                              //                           .pop();
                              //                       showDialog(
                              //                           barrierDismissible:
                              //                               false,
                              //                           context: context,
                              //                           builder:
                              //                               (childContext) {
                              //                             return AlertDialog(
                              //                               title: Text(
                              //                                   'Updating Status'),
                              //                               content: Container(
                              //                                 child: Column(
                              //                                   mainAxisSize:
                              //                                       MainAxisSize
                              //                                           .min,
                              //                                   children: [
                              //                                     Center(
                              //                                       child:
                              //                                           CircularProgressIndicator(),
                              //                                     ),
                              //                                     SizedBox(
                              //                                       height: 10,
                              //                                     ),
                              //                                     Text(
                              //                                         'Please wait'),
                              //                                   ],
                              //                                 ),
                              //                               ),
                              //                             );
                              //                           });
                              //                       context
                              //                           .read<Login>()
                              //                           .updateUser(u.phone, {
                              //                         "disabled":
                              //                             value == 'Disabled'
                              //                       }).then((value) =>
                              //                               Navigator.of(
                              //                                       context)
                              //                                   .pop());
                              //                     },
                              //                   )
                              //                 ],
                              //               );
                              //             });
                              //       }),
                              // ),
                              // DataCell(IconButton(
                              //   splashRadius: 25,
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     LineIcons.edit,
                              //     color: Colors.grey,
                              //   ),
                              // )),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: u.name +
                                                "\n" +
                                                u.email +
                                                "\n" +
                                                u.phone +
                                                (u.company != null
                                                    ? ("\n" + u.company!)
                                                    : "")));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height -
                                                        100,
                                                    right: 20,
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        200),
                                                dismissDirection:
                                                    DismissDirection.horizontal,
                                                content: Text(
                                                    'Copied to clipboard')));
                                      },
                                      tooltip: "Copy Row",
                                      splashRadius: 25,
                                      icon: Icon(
                                        LineIcons.copy,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                    tooltip: "Delete",
                                    splashRadius: 25,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (innerContext) {
                                            return AlertDialog(
                                              title: Text('Are you sure?'),
                                              content: Text(
                                                  'Do you want to delete this user?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    Navigator.pop(innerContext);
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder:
                                                            (childContext) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Deleting ...'),
                                                            content: Container(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                      'deleting user ...')
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                    context
                                                        .read<Login>()
                                                        .deleteUser(u.phone)
                                                        .then((value) =>
                                                            Navigator.pop(
                                                                context));
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('No'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      LineIcons.trash,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ))
                            ]);
                      }).toList());
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber,
                  ));
                }
              }),
        ),
      ),
    );
  }
}
