// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final List<String> _pin = [];

  void _onKeyPress(String value) {
    setState(() {
      if (value == "Clear") {
        _pin.clear();
      } else if (_pin.length < 4) {
        _pin.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with clock icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22.sp,
                    color: Colors.blue, // Changed to blue
                  ),
                ],
              ),
            ),
            Spacer(),
            // Logo, title, and PIN prompt
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and LOYVERSE in the same line
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo vision.png", // Replace with your logo asset path
                      height: 10.h,
                    ),
                    SizedBox(width: 2.w),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "LOY",
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "VERSE",
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Expanded Point of Sale Text
                SizedBox(height: 1.h),
                Text(
                  "POINT OF SALE",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                // PIN prompt
                Text(
                  "Enter PIN",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                // PIN circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: CircleAvatar(
                        radius: 2.h,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 1.8.h,
                          backgroundColor:
                              index < _pin.length ? Colors.blue : Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue, // Blue outline
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Keypad with grey grid lines
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Stack(
                children: [
                  // Grid lines in grey
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GridPainter(),
                    ),
                  ),
                  // Keypad buttons
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 9) {
                        // Empty space for layout consistency
                        return SizedBox.shrink();
                      } else if (index == 11) {
                        // "Clear" button
                        return GestureDetector(
                          onTap: () => _onKeyPress("Clear"),
                          child: Center(
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Numeric keys
                        String key =
                            (index == 10 ? "0" : (index + 1).toString());
                        return GestureDetector(
                          onTap: () => _onKeyPress(key),
                          child: Center(
                            child: Text(
                              key,
                              style: TextStyle(
                                fontSize: 22.sp, // Larger font for numbers
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the grid lines
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color.fromARGB(255, 152, 147, 147) // Grey color for grid lines
      ..strokeWidth = 1;

    // Number of rows and columns
    const rows = 4;
    const columns = 3;

    // Calculate the width and height of each cell
    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;

    // Draw horizontal lines
    for (int i = 1; i < rows; i++) {
      final y = i * cellHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical lines
    for (int i = 1; i < columns; i++) {
      final x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
