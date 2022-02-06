import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:line_icons/line_icons.dart';
import 'package:makemywindoor_admin/config/size_config.dart';
import 'package:makemywindoor_admin/home.dart';
import 'package:makemywindoor_admin/model/product.dart';
import 'package:makemywindoor_admin/services/productService.dart';
import 'package:provider/provider.dart';

class CreateProduct extends StatefulWidget {
  CreateProduct({Key? key}) : super(key: key);

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  GlobalKey<FormState> createProductKey = new GlobalKey<FormState>();
  Product product = Product.empty();
  @override
  void initState() {
    super.initState();
  }

  int _isChecked = -1;
  List<String> productType = ["Aluminium", "UPVC", "Glass"];
  // String _currText = '';
  @override
  Widget build(BuildContext context) {
    return Home(
      Expanded(
        flex: 10,
        // width: SizeConfig.screenWidth! / 1.3,
        // height: SizeConfig.screenHeight,
        // padding: EdgeInsets.only(bottom: 30),
        child: Form(
          key: createProductKey,
          child: Column(
            children: <Widget>[
              HeaderContainer("Choose Image"),
              Expanded(
                // flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _textInput(
                          hint: "Product Name", icon: LineIcons.box, index: 1),
                      _textInput(
                          hint: "Description", icon: LineIcons.info, index: 2),
                      _textInput(
                          hint: "Price",
                          icon: LineIcons.indianRupeeSign,
                          index: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Product Type :'),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: productType
                                  .map((t) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width:
                                              SizeConfig.blockSizeHorizontal! *
                                                  20,
                                          child: CheckboxListTile(
                                            checkColor: Colors.black,
                                            activeColor: Colors.amber,
                                            title: Text(t),
                                            value: _isChecked ==
                                                productType.indexOf(t),
                                            onChanged: (val) {
                                              if (_isChecked ==
                                                  productType.indexOf(t)) {
                                                setState(() {
                                                  _isChecked = -1;
                                                });
                                              } else {
                                                setState(() {
                                                  _isChecked =
                                                      productType.indexOf(t);
                                                  // if (val == _isChecked) {
                                                  //   _currText = t;
                                                  // }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: ButtonWidget(
                            btnText: "CREATE",
                            onClick: () {
                              log('postProduct =============');
                              if (createProductKey.currentState!.validate()) {
                                log('postProduct ============validation done=');
                                createProductKey.currentState!.save();
                                if (_isChecked != -1) {
                                  log('postProduct ========save done=====');
                                  product.type = productType[_isChecked];

                                  if (mediaInfoGlobal != null) {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Creating Product'),
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
                                    uploadFile(mediaInfoGlobal!, product.type,
                                        context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(MaterialBanner(
                                      content: const Text(
                                          'Product Image is required.'),
                                      leading:
                                          const Icon(LineIcons.productHunt),
                                      backgroundColor: Colors.red.shade100,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentMaterialBanner();
                                            },
                                            child: const Text('OK')),
                                      ],
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(MaterialBanner(
                                    content:
                                        const Text('Product type is required.'),
                                    leading: const Icon(LineIcons.productHunt),
                                    backgroundColor: Colors.red.shade100,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentMaterialBanner();
                                          },
                                          child: const Text('OK')),
                                    ],
                                  ));
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget HeaderContainer(String text) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Center(
            child: localImage != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100)),
                      child: Image.memory(
                        localImage!,
                        height: SizeConfig.blockSizeVertical! * 100,
                        width: SizeConfig.blockSizeHorizontal! * 100,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100)),
                      child: Image.asset(
                        "assets/imgs/picker.jpg",
                        height: SizeConfig.blockSizeVertical! * 100,
                        width: SizeConfig.blockSizeHorizontal! * 100,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: orangeColors),
                onPressed: () {
                  imagePicker();
                },
                child: Text(text),
              )),
        ],
      ),
    );
  }

  Uint8List? localImage;
  MediaInfo? mediaInfoGlobal;
  imagePicker() {
    log('ImagePickerWeb----------');
    return ImagePickerWeb.getImageInfo.then((MediaInfo mediaInfo) {
      setState(() {
        localImage = mediaInfo.data!;
        mediaInfoGlobal = mediaInfo;
      });
    });
  }

  //Getting Downloaded URI directly
  uploadFile(MediaInfo mediaInfo, String productType, BuildContext context) {
    try {
      // String? mimeType = mime(basename(mediaInfo.fileName!));
      // var metaData = UploadMetadata(contentType: mimeType);
      // log('firestore path=======' + mediaInfo.fileName!);
      // var finalStorageURL = ref + '/' + productType;
      // log('path=======llll' + finalStorageURL.toString());
      Reference storageReference =
          FirebaseStorage.instance.ref(productType).child(product.productId);

      storageReference
          .putData(mediaInfo.data!, SettableMetadata(contentType: "image/png"))
          .then((snapshot) => {
                Future.delayed(Duration(seconds: 1)).then((value) => {
                      snapshot.ref.getDownloadURL().then((uri) {
                        // imageUri = uri;
                        // product.imageUrl = imageUri.toString();
                        product.imageUrl = uri;
                        ProductService productService =
                            Provider.of<ProductService>(context, listen: false);
                        productService
                            .postProduct(product.toMap())
                            .then((value) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Product Created Successfully',
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                            backgroundColor: Colors.green,
                          ));
                          createProductKey.currentState!.reset();
                          _isChecked = -1;
                        });
                        // log('Download URL: ${imageUri.toString()}');
                      })
                    })
              });
    } catch (e) {
      print('File Upload Error: $e');
    }
  }

  Widget _textInput({controller, hint, icon, int? index}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        onSaved: (value) => onSaved(index!, value!),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  onSaved(int index, String value) {
    switch (index) {
      case 1:
        product.name = value;

        break;
      case 2:
        product.description = value;
        break;
      case 3:
        product.price = value;

        product.productId = DateTime.now().millisecondsSinceEpoch.toString();

        break;
    }
  }
}

Color orangeColors = Color(0xffFFBF00);
Color orangeLightColors = Color(0xffFFBF00);

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final onClick;

  ButtonWidget({required this.btnText, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
