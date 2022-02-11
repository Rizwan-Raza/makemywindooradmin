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
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: context.read<ProductService>().getProduct(),
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
                        // DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Delete'))
                      ],
                      rows: snapshot.data!.docs.map((e) {
                        Product p = Product.fromMap(e.data());
                        return DataRow(cells: [
                          DataCell(Container(
                            margin: EdgeInsets.all(10),
                            width: SizeConfig.blockSizeHorizontal! * 5,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      p.imageUrl,
                                    ),
                                    fit: BoxFit.cover),
                                color: Colors.grey[200],
                                shape: BoxShape.circle),
                          )),
                          DataCell(Text(p.name)),
                          DataCell(Text(p.description)),
                          DataCell(Text(p.type)),
                          DataCell(Row(children: [
                            Text('₹ ', style: TextStyle(fontFamily: 'Arial')),
                            Text(p.price)
                          ])),
                          // DataCell(IconButton(
                          //   splashRadius: 25,
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     LineIcons.edit,
                          //     color: Colors.grey,
                          //   ),
                          // )),
                          DataCell(IconButton(
                            splashRadius: 25,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (innerContext) {
                                    return AlertDialog(
                                      title: Text('Are you sure?'),
                                      content: Text(
                                          'Do you want to delete this product?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            Navigator.pop(innerContext);
                                            showDialog(
                                                barrierDismissible: false,
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
                                                              'deleting product ...')
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            context
                                                .read<ProductService>()
                                                .deleteProduct(
                                                    p.productId, p.type)
                                                .then((value) =>
                                                    Navigator.pop(context));
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
