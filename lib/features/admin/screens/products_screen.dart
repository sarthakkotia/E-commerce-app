import 'package:ecommerce_app/common/loader.dart';
import 'package:ecommerce_app/features/admin/screens/add_product_screen.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void navigatetoAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  fetchAllproducts() async {
    var logger = Logger(filter: null, level: Level.warning);
    logger.w("inside fetch All products");
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllproducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: const Center(
              child: Text("Products"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigatetoAddProduct,
              tooltip: "Add a Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
