import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/model/product.dart';
import 'package:makemywindoor_admin/model/project.dart';
import 'package:makemywindoor_admin/services/project_service.dart';

class CustomerOrders extends StatefulWidget {
  CustomerOrders({Key? key}) : super(key: key);

  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  ProjectServices? pService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pService = new ProjectServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: pService!.getAllProjects(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DataTable(
                dataRowHeight: 72,
                columns: [
                  // DataColumn(label: Text('Product Image')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Product Description')),
                  DataColumn(label: Text('Product Type')),
                  DataColumn(label: Text('Product Price')),
                  DataColumn(label: Text('Edit')),
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
                    DataCell(Text(p.totalCost.toString())),
                    DataCell(Text(p.totalCharge.toString())),
                    DataCell(Text(p.createdOn.toString())),
                    DataCell(Text(p.createdBy)),
                    DataCell(IconButton(
                      splashRadius: 25,
                      onPressed: () {},
                      icon: Icon(
                        LineIcons.edit,
                        color: Colors.grey,
                      ),
                    )),
                    DataCell(IconButton(
                      splashRadius: 25,
                      onPressed: () {},
                      icon: Icon(
                        LineIcons.trash,
                        color: Colors.red,
                      ),
                    ))
                  ]);
                }).toList());
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
