import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:makemywindoor_admin/component/project_detail.dart';
import 'package:makemywindoor_admin/model/project.dart';
import 'package:makemywindoor_admin/services/project_service.dart';
import 'package:provider/provider.dart';

class TodayOrders extends StatelessWidget {
  const TodayOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: Provider.of<ProjectServices>(context).getTodaysProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Project project =
                    Project.fromMap(snapshot.data!.docs[index].data());
                return Card(
                  child: InkWell(
                    onTap: () {
                      showMore(context, project);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(project.projectDetails.projectName),
                        subtitle: Text(project.projectDetails.customerName +
                            '\n' +
                            project.projectDetails.customerNumber),
                        trailing:
                            Text('₹ ' + project.totalCharge.round().toString()),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });

    // return ListView.builder(
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     itemCount: 2,
    //     itemBuilder: (context, index) {
    //       return Container(
    //         height: SizeConfig.blockSizeVertical! * 10,
    //         child: Card(
    //           color: Colors.amber,
    //           margin: EdgeInsets.all(10),
    //           shadowColor: Colors.black,
    //           shape: BeveledRectangleBorder(
    //             borderRadius: BorderRadius.circular(0.0),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [Text('order' + index.toString()), Text('date')],
    //           ),
    //         ),
    //       );
    //     });
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
