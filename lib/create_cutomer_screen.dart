// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vision_point_of_sale/modifier_screen.dart';

class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Create customer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 22.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: TextButton(
              onPressed: () {
                // Add save functionality
              },
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateModifierScreen(),
                    ),
                  );
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              _buildInputField(Icons.person, "Name"),
              _buildInputField(Icons.email, "Email"),
              _buildInputField(Icons.phone, "Phone"),
              _buildInputField(Icons.location_on, "Address"),
              _buildInputField(null, "City", isCustomField: true),
              _buildInputField(null, "Region", isCustomField: true),
              _buildInputField(null, "Postal code", isCustomField: true),
              _buildDropDownField("Country"),
              _buildInputField(Icons.qr_code, "Customer code",
                  isCustomField: true),
              _buildInputField(Icons.note, "Note"), // Added Note field
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(IconData? icon, String label,
      {bool isCustomField = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.8.h),
      child: Row(
        children: [
          if (isCustomField) SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                prefixIcon: icon != null
                    ? Icon(
                        icon,
                        size: 22.sp,
                        color: Colors.grey.shade700,
                      )
                    : null,
                labelText: label,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.3,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDownField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.8.h),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.3,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 22.sp,
                color: Colors.grey.shade700,
              ),
              items: const [
                DropdownMenuItem(
                  value: "Pakistan",
                  child: Text("Pakistan"),
                ),
                DropdownMenuItem(
                  value: "India",
                  child: Text("India"),
                ),
                DropdownMenuItem(
                  value: "USA",
                  child: Text("USA"),
                ),
              ],
              onChanged: (value) {
                // Handle country selection
              },
              dropdownColor: Colors.white,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black, // Ensures no color change on selection
              ),
            ),
          ),
        ],
      ),
    );
  }
}
