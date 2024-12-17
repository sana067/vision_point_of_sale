// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateModifierScreen extends StatefulWidget {
  const CreateModifierScreen({Key? key}) : super(key: key);

  @override
  State<CreateModifierScreen> createState() => _CreateModifierScreenState();
}

class _CreateModifierScreenState extends State<CreateModifierScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _optionControllers = [];
  final TextEditingController _modifierNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addOptionField() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Perform save operation here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields.')),
      );
    }
  }

  @override
  void dispose() {
    _modifierNameController.dispose();
    _priceController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Create modifier',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 22.sp),
              onPressed: () {},
            ),
            actions: [
              TextButton(
                onPressed: _saveForm,
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      controller: _modifierNameController,
                      label: "Modifier name",
                    ),
                    SizedBox(height: 2.h),
                    ..._buildOptionFields(),
                    SizedBox(height: 2.h),
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    _buildInputField(
                      controller: _priceController,
                      label: "Rs0.00",
                      isNumeric: true,
                    ),
                    SizedBox(height: 3.h),
                    _buildAddOptionRow(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool isNumeric = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey.shade500),
        contentPadding: EdgeInsets.only(bottom: 1.h, top: 1.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  List<Widget> _buildOptionFields() {
    return _optionControllers
        .asMap()
        .entries
        .map(
          (entry) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.drag_indicator,
                  color: Colors.grey.shade400, size: 20.sp),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildInputField(
                  controller: entry.value,
                  label: "Option name",
                ),
              ),
              SizedBox(width: 2.w),
              IconButton(
                onPressed: () {
                  setState(() {
                    _optionControllers.removeAt(entry.key);
                  });
                },
                icon: Icon(Icons.delete,
                    color: Colors.grey.shade400, size: 20.sp),
              ),
            ],
          ),
        )
        .toList();
  }

  Widget _buildAddOptionRow() {
    return GestureDetector(
      onTap: _addOptionField,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.add_circle_outline, color: Colors.blue, size: 20.sp),
          SizedBox(width: 2.w),
          Text(
            'ADD OPTION',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
