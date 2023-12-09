import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:frontend/core/constants/text_theme.dart";
import "package:frontend/core/providers/order_provider.dart";
import "package:frontend/models/order_model.dart";
import "package:frontend/widgets/CustomButton.dart";
import "package:frontend/widgets/CustomFormField.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:intl/intl.dart';
import 'dart:math';

import "package:provider/provider.dart";

class CreateOrderView extends StatefulWidget {
  const CreateOrderView({super.key});

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late TextEditingController _packageName;
  late TextEditingController _pin;
  late TextEditingController _weight;
  late TextEditingController _price;
  late TextEditingController _deliveryName;
  late TextEditingController _deliveryContact;
  late TextEditingController _status;
  late TextEditingController _deliveryDate;

  @override
  void initState() {
    super.initState();
    _packageName = TextEditingController(text: "");
    _pin = TextEditingController(text: "");
    _weight = TextEditingController(text: "");
    _price = TextEditingController(text: "");
    _deliveryName = TextEditingController(text: "");
    _deliveryContact = TextEditingController(text: "");
    _status = TextEditingController(text: "On Process");
    _deliveryDate = TextEditingController(text: "");
  }

  @override
  void dispose(){
    super.dispose();
    _packageName.dispose();
    _pin.dispose();
    _weight.dispose();
    _price.dispose();
    _deliveryName.dispose();
    _deliveryContact.dispose();
    _status.dispose();
    _deliveryDate.dispose();
  }

  void generateRandomPin() {
    const digits = '0123456789';
    final random = Random();

    String pinCode = "";
    for (int i = 0; i < 8; i++) { 
      pinCode += digits[random.nextInt(digits.length)];
    }

    _pin.text = pinCode;
  }

  void clearController(){
    _packageName.clear();
    _pin.clear();
    _weight.clear();
    _price.clear();
    _deliveryName.clear();
    _deliveryContact.clear();
    _status.clear();
    _deliveryDate.clear();
  }

  Future<void> _createOrder(OrderProvider orderProvider) async {
    await orderProvider.createOrder([
      OrderModel(
        name: _packageName.text.trim(),
        pin: _pin.text.trim(),
        weight: _weight.text.trim(),
        price: _price.text.trim(),
        status: _status.text.trim(),
        deliveryName: _deliveryName.text.trim(),
        deliveryContact: _deliveryContact.text.trim(),
        deliveryDate: _deliveryDate.text.trim(),
      ).toMap(),
    ]);

    clearController();
  }


  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(FeatherIcons.arrowLeft, color: Colors.grey[800])),
                    const SizedBox(width: 10),
                    titleText(
                      "Create Order",
                      titleSize: 24.0,
                      titleWeight: FontWeight.bold,
                      titleColor: Colors.grey[800]
                    )
                  ],),
                ),
            
                // Package Details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withAlpha(50))
                    ),
                    child: (
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                             padding: const EdgeInsets.symmetric(horizontal:20.0),
                             child: titleText(
                              "Package Details",
                              titleSize: 20.0,
                              titleColor: Theme.of(context).colorScheme.secondary,
                              titleWeight: FontWeight.bold)),
            
                          const SizedBox(height: 20),
            
                          CustomFormField(
                            formData: _packageName,
                            formLabelText: "Name" ),
                          
                          const SizedBox(height: 10),
            
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  formData: _price,
                                  formLabelText: "Price"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: bodyText(
                                    "PHP",
                                    bodySize: 14,
                                    bodyColor: Colors.white,
                                    bodyWeight: FontWeight.w600
                                  ),
                                )
                              )
                            ],
                          ),
            
                          const SizedBox(height: 10),
            
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  formData: _weight,
                                  formLabelText: "Weight",
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: bodyText(
                                    "KG",
                                    bodySize: 14,
                                    bodyColor: Colors.white,
                                    bodyWeight: FontWeight.w600
                                  ),
                                )
                              )
                            ],
                          ),

                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              controller: _deliveryDate,
                              readOnly: true,
                              decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.primary.withAlpha(25),
                              counterText: "",
                              labelStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                              hintText: "Delivery Date",
                              suffixIcon: Icon(FeatherIcons.calendar, color: Colors.grey[600]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade200)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade200)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red.shade300)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Theme.of(context).colorScheme.primary))),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context, 
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950), 
                                  lastDate: DateTime(2100));

                                if(pickedDate != null){
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  setState(() {
                                    _deliveryDate.text = formattedDate;
                                  });
                                }
                              },
                            
                            ),
                          )
                        ],
                      )
                    )
                  ),
                ),
            
                //Setup PIN Code
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withAlpha(50))
                    ),
                    child: (
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                             padding: const EdgeInsets.symmetric(horizontal:20.0),
                             child: titleText(
                              "Setup 8-PIN Code",
                              titleSize: 20.0,
                              titleColor: Theme.of(context).colorScheme.secondary,
                              titleWeight: FontWeight.bold)),
            
                          const SizedBox(height: 20),
            
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  formData: _pin,
                                  formLabelText: "PIN Code"),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  generateRandomPin()
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: bodyText(
                                      "Auto Generate",
                                      bodySize: 14.0,
                                      bodyColor: Colors.white,
                                      bodyWeight: FontWeight.w600
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    )
                  ),
                ),
            
                //Driver Details 
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withAlpha(50))
                    ),
                    child: (
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                             padding: const EdgeInsets.symmetric(horizontal:20.0),
                             child: titleText(
                              "Driver Details",
                              titleSize: 20.0,
                              titleColor: Theme.of(context).colorScheme.secondary,
                              titleWeight: FontWeight.bold)),
            
                          const SizedBox(height: 20),
            
                          CustomFormField(
                            formData: _deliveryName,
                            formLabelText: "Name" ),
                          
                          const SizedBox(height: 10),
            
                          CustomFormField(
                            formData: _deliveryContact,
                            formLabelText: "Contact Number" ),                  
                        ],
                      )
                    )
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    btnColor: Theme.of(context).colorScheme.primary,
                    btnOnTap: () {
                      _createOrder(orderProvider);
                    },
                    btnChild: Text("Submit Order",
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.background)),
                )),

                const SizedBox(height: 30),
              ],
            ),
          )
        ),
      )
    );
  }

}