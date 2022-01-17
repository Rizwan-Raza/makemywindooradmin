import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/home.dart';
import 'package:makemywindoor_admin/model/product.dart';
import 'package:makemywindoor_admin/services/productService.dart';
import 'package:provider/provider.dart';

class MyProducts extends StatefulWidget {
  MyProducts({Key? key}) : super(key: key);

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    return Home(
      Expanded(
        flex: 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: context.read<ProductService>().getProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                    dataRowHeight: 72,
                    columns: [
                      DataColumn(label: Text('Product Image')),
                      DataColumn(label: Text('Product Name')),
                      DataColumn(label: Text('Product Description')),
                      DataColumn(label: Text('Product Type')),
                      DataColumn(label: Text('Product Price')),
                      DataColumn(label: Text('Edit')),
                      DataColumn(label: Text('Delete'))
                    ],
                    rows: snapshot.data!.docs.map((e) {
                      Product p = Product.fromJson(e.data());
                      return DataRow(cells: [
                        DataCell(Container(
                          margin: EdgeInsets.all(10),
                          width: SizeConfig.blockSizeHorizontal! * 5,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    p.pImageURL!,
                                  ),
                                  fit: BoxFit.cover),
                              color: Colors.red,
                              shape: BoxShape.circle),
                        )),
                        DataCell(Text(p.pName!)),
                        DataCell(Text(p.pDescription!)),
                        DataCell(Text(p.pType!)),
                        DataCell(Text('₹ ' + p.pPrice!)),
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
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                ));
              }
            }),
      ),
    );
  }
}
