// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaxApp extends StatefulWidget {
  const TaxApp({Key? key}) : super(key: key);

  @override
  State<TaxApp> createState() => _TaxAppState();
}

class _TaxAppState extends State<TaxApp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _taxRateFocusNode = FocusNode();

  bool _isNameFieldValid = true;
  bool _isTaxRateValid = true;
  bool _isButtonEnabled = true;
  String _errorMessage = '';

  String _selectedType = "Included in the price";
  final List<String> _typeOptions = [
    "Included in the price",
    "Added to the price",
  ];

  @override
  void initState() {
    super.initState();

    _taxRateFocusNode.addListener(() {
      if (_taxRateFocusNode.hasFocus) {
        setState(() {
          if (_nameController.text.trim().isEmpty) {
            _isNameFieldValid = false;
            _errorMessage = 'This field cannot be blank';
            _isButtonEnabled = false;
          }
        });
      }
    });

    _nameFocusNode.addListener(() {
      setState(() {
        _isNameFieldValid = true;
        _errorMessage = '';
        _isButtonEnabled = _validateForm();
      });
    });
  }

  // Function to validate the form fields
  bool _validateForm() {
    return _isNameFieldValid &&
        _isTaxRateValid &&
        _nameController.text.isNotEmpty &&
        _taxRateController.text.isNotEmpty;
  }

  // Function to handle Save button press
  void _handleSave() {
    if (_validateForm()) {
      // Handle save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tax Saved Successfully")),
      );
    } else {
      // Show error message if validation fails
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            leading: const Icon(Icons.arrow_back, color: Colors.white),
            title: Text(
              "Create tax",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Center(
                  child: GestureDetector(
                    onTap: _isButtonEnabled ? _handleSave : null,
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        color: _isButtonEnabled ? Colors.white : Colors.grey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Input
                  TextField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        color: _isNameFieldValid
                            ? Colors.grey.shade800
                            : Colors.red,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _isNameFieldValid ? Colors.blue : Colors.red,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _isNameFieldValid
                              ? Colors.grey.shade400
                              : Colors.red,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isNameFieldValid = value.trim().isNotEmpty;
                        _isButtonEnabled = _validateForm();
                      });
                    },
                  ),
                  if (!_isNameFieldValid)
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),

                  SizedBox(height: 3.h),

                  // Tax Rate Input
                  TextField(
                    controller: _taxRateController,
                    focusNode: _taxRateFocusNode,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      labelText: "Tax rate, %",
                      labelStyle: TextStyle(
                        fontSize: 16.sp,
                        color:
                            _isTaxRateValid ? Colors.grey.shade800 : Colors.red,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isTaxRateValid =
                            value.isNotEmpty && double.tryParse(value) != null;
                        _isButtonEnabled = _validateForm();
                      });
                    },
                  ),

                  SizedBox(height: 3.h),

                  // Type Dropdown
                  Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedType,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 22.sp,
                      color: Colors.black,
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedType = newValue!;
                      });
                    },
                    items: _typeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 5.h),

                  // APPLY TO ITEMS Button
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: _isButtonEnabled
                                ? Colors.blue
                                : Colors.grey.shade400,
                            width: 0.5.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.sp),
                          ),
                        ),
                        onPressed: _isButtonEnabled ? () {} : null,
                        child: Text(
                          "APPLY TO ITEMS",
                          style: TextStyle(
                            color: _isButtonEnabled ? Colors.blue : Colors.grey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
