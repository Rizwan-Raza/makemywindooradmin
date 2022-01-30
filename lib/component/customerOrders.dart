import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/component/project_detail.dart';
import 'package:makemywindoor_admin/home.dart';
import 'package:makemywindoor_admin/model/project.dart';
import 'package:makemywindoor_admin/services/project_service.dart';
import 'package:provider/provider.dart';

class CustomerOrders extends StatefulWidget {
  CustomerOrders({Key? key}) : super(key: key);

  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  late ProjectServices pService;
  @override
  void initState() {
    super.initState();
    pService = Provider.of<ProjectServices>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Home(
      Expanded(
        flex: 10,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: pService.getAllProjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DataTable(
                dataRowHeight: 72,
                columns: [
                  // DataColumn(label: Text('Product Image')),
                  DataColumn(label: Text('Project Name')),
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Customer Phone')),
                  DataColumn(label: Text('Project Charges')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('View more')),
                  DataColumn(label: Text('Delete'))
                ],
                rows: snapshot.data!.docs.map((e) {
                  Project p = Project.fromMap(e.data());
                  return DataRow(cells: [
                    // DataCell(Container(
                    //   margin: EdgeInsets.all(10),
                    //   width: SizeConfig.blockSizeHorizontal! * 5,
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(
                    //             p.pImageURL!,
                    //           ),
                    //           fit: BoxFit.cover),
                    //       color: Colors.red,
                    //       shape: BoxShape.circle),
                    // )),
                    DataCell(Text(p.projectDetails.projectName)),
                    DataCell(Text(p.projectDetails.customerName)),
                    DataCell(Text(p.projectDetails.customerNumber)),
                    DataCell(Text('₹ ' + p.totalCharge.round().toString())),
                    DataCell(
                      DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey[300],
                              filled: true),
                          items: [
                            DropdownMenuItem(
                              child: Text('Pending'),
                              value: 'Pending',
                            ),
                            DropdownMenuItem(
                              child: Text('In Progress'),
                              value: 'In Progress',
                            ),
                            DropdownMenuItem(
                              child: Text('Completed'),
                              value: 'Completed',
                            ),
                          ],
                          value: p.status,
                          icon: Icon(LineIcons.angleDown),
                          onChanged: (value) {
                            showDialog(
                                context: context,
                                builder: (parentContext) {
                                  return AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text(
                                        'Do you want to change the status of this project to $value?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(parentContext).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(parentContext).pop();
                                          showDialog(
                                              context: context,
                                              builder: (childContext) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Updating Status'),
                                                  content: Container(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                          pService
                                              .updateProjectStatus(
                                                  p.projectID, value!)
                                              .then((value) =>
                                                  Navigator.of(context).pop());
                                        },
                                      )
                                    ],
                                  );
                                });
                          }),
                    ),

                    DataCell(IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        showMore(context, p);
                      },
                      icon: Icon(
                        LineIcons.alternateExternalLink,
                        color: Colors.blue,
                      ),
                    )),
                    DataCell(IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (innerContext) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content:
                                    Text('Do you want to delete this product?'),
                                actions: [
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      Navigator.pop(innerContext);
                                      showDialog(
                                          context: context,
                                          builder: (childContext) {
                                            return AlertDialog(
                                              title: Text('Deleting ...'),
                                              content: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        'deleteing product ...')
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                      pService.deleteProject(p.projectID).then(
                                          (value) => Navigator.pop(context));
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
                    ))
                  ]);
                }).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void showMore(BuildContext context, Project p) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ProjectDetailsScreen(
              project: p,
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
