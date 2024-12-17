import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// ignore: depend_on_referenced_packages

class CreatePrinterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Printer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(fontSize: 12.sp),
              ),
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Printer model',
                labelStyle: TextStyle(fontSize: 12.sp),
              ),
              items: <String>['No printer', 'Printer 1', 'Printer 2']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 12.sp)),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Text('Print receipts and bills',
                    style: TextStyle(fontSize: 12.sp)),
                Switch(value: false, onChanged: (value) {}),
              ],
            ),
            SizedBox(height: 2.h),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.print, size: 15.sp),
              label: Text('PRINT TEST', style: TextStyle(fontSize: 12.sp)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save, size: 20.sp),
      ),
    );
  }
}
