import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/common/widgets/custom_button.dart';
import 'package:ecommerce_app/common/widgets/custom_textfield.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion"
  ];

  String category = "Mobiles";
  List<File> images = [];
  final _addProductformKey = GlobalKey<FormState>();

  void sellProduct() {
    if (_addProductformKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductformKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select Product Images",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[400]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      controller: productNameController,
                      hintText: "Product Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: descriptionController,
                      hintText: "Description",
                      maxLines: 7,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: priceController,
                      hintText: "Price",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: quantityController,
                      hintText: "Quantity",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownMenu(
                        dropdownMenuEntries: productCategories.map(
                          (e) {
                            return DropdownMenuEntry(value: e, label: e);
                          },
                        ).toList(),
                        initialSelection: category,
                        onSelected: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(onTap: sellProduct, text: "Sell")
                  ],
                ),
              )),
        ));
  }
}
