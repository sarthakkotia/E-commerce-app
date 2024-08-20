import 'dart:io';

import 'package:ecommerce_app/common/loader.dart';
import 'package:ecommerce_app/common/widgets/custom_textfield.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/address/services/address_services.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({required this.totalAmount, super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFromKey = GlobalKey<FormState>();
  final TextEditingController _housecontroller = TextEditingController();
  final TextEditingController _streetcontroller = TextEditingController();
  final TextEditingController _pincodecontroller = TextEditingController();
  final TextEditingController _citycontroller = TextEditingController();
  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    _housecontroller.dispose();
    _citycontroller.dispose();
    _pincodecontroller.dispose();
    _streetcontroller.dispose();
  }

  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
// we could get to add all the individual items or we could just add the total amount
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: "Total Item",
          status: PaymentItemStatus.final_price),
    );
    super.initState();
  }

  //these funcitons are called on success
  void onGPayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      //store the address
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      //store the address
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void testonGPayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      //store the address
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  // we need to check address before moving onto the payment so do validation
  void payPressed(String address) {
    addressToBeUsed = "";

    bool isForm = _citycontroller.text.isNotEmpty ||
        _housecontroller.text.isNotEmpty ||
        _pincodecontroller.text.isNotEmpty ||
        _streetcontroller.text.isNotEmpty;
    if (isForm) {
      if (_addressFromKey.currentState!.validate()) {
        addressToBeUsed =
            "${_housecontroller.text}, ${_streetcontroller.text}, ${_citycontroller.text} - ${_pincodecontroller.text}";
      } else {
        // when throwing the exception we would catch it to snackbar
        throw Exception('Please enter all the values');
      }
    } else if (address.isNotEmpty) {
      addressToBeUsed = address;
    } else {
      showSnackBar(context, "Error");
    }
    testonGPayResult();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              Form(
                key: _addressFromKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: _housecontroller,
                      hintText: "Flat, House no, Building",
                    ),
                    CustomTextfield(
                      controller: _streetcontroller,
                      hintText: "Area, Street",
                    ),
                    CustomTextfield(
                      controller: _pincodecontroller,
                      hintText: "Pincode",
                    ),
                    CustomTextfield(
                      controller: _citycontroller,
                      hintText: "Town/City",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Platform.isAndroid
                    ? FutureBuilder(
                        future: PaymentConfiguration.fromAsset("gpay.json"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GooglePayButton(
                              height: 50,
                              width: double.infinity,
                              type: GooglePayButtonType.checkout,
                              theme: GooglePayButtonTheme.light,
                              paymentConfiguration: snapshot.data!,
                              paymentItems: paymentItems,
                              onPressed: () => payPressed(address),
                              onPaymentResult: onGPayResult,
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return const Loader();
                          }
                        },
                      )
                    : FutureBuilder(
                        future: PaymentConfiguration.fromAsset("applepay.json"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ApplePayButton(
                              onPressed: () => payPressed(address),
                              height: 50,
                              width: double.infinity,
                              type: ApplePayButtonType.buy,
                              style: ApplePayButtonStyle.whiteOutline,
                              paymentConfiguration: snapshot.data!,
                              paymentItems: paymentItems,
                              onPaymentResult: onApplePayResult,
                              loadingIndicator: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          } else {
                            return const Loader();
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
