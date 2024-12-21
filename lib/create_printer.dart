import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreatePrinterPage extends StatefulWidget {
  const CreatePrinterPage({super.key});

  @override
  State<CreatePrinterPage> createState() => _CreatePrinterPageState();
}

class _CreatePrinterPageState extends State<CreatePrinterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPrinter;
  bool _printReceipts = false;
  bool _printOrders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Create printer',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 18.sp,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Handle save logic
              }
            },
            child: Text(
              'SAVE',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 16.sp),
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Printer model',
                  labelStyle: TextStyle(fontSize: 16.sp),
                  border: UnderlineInputBorder(),
                ),
                value: _selectedPrinter,
                items: const [
                  DropdownMenuItem(
                    value: 'No printer',
                    child: Text('No printer'),
                  ),
                  DropdownMenuItem(
                    value: 'Bluetooth printer',
                    child: Text('Bluetooth printer'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPrinter = value;
                  });
                },
                menuMaxHeight: 200.0,
                dropdownColor: Colors.white,
                alignment: Alignment.centerLeft,
                isExpanded: true,
              ),
              if (_selectedPrinter == 'Bluetooth printer') ...[
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Bluetooth printer',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 2.w),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Search', style: TextStyle(fontSize: 16.sp)),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Print receipts and bills',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Switch(
                    value: _printReceipts,
                    onChanged: (value) {
                      setState(() {
                        _printReceipts = value;
                      });
                    },
                  ),
                ],
              ),
              if (_printReceipts) ...[
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Automatically print receipt',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Print order',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Switch(
                    value: _printOrders,
                    onChanged: (value) {
                      setState(() {
                        _printOrders = value;
                      });
                    },
                  ),
                ],
              ),
              if (_printOrders) ...[
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Print single item per order ticket',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black, width: 0.5.sp),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.print, size: 18.sp),
                      SizedBox(width: 2.w),
                      Text(
                        'PRINT TEST',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
