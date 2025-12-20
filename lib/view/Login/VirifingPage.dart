import 'package:flutter/material.dart';
import 'package:flutter_project/components/NotAcceptedYet.dart';
import 'package:flutter_project/view/Login/ProfileForm.dart';
//import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project/view/MainRoutes/homepage.dart';
import 'package:flutter_project/api/api_service.dart';

class virifingpage extends StatefulWidget {
  final String token;
  //final String phone;
  const virifingpage({Key? key, /*required this.phone*/ required this.token})
    : super(key: key);

  @override
  State<virifingpage> createState() => _virifingpageState();
}

class _virifingpageState extends State<virifingpage> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  void handleVerify() async {
    final res = await ApiService.verifyOtp(otpController.text, widget.token);
    if (res['status'] == 'success') {
      final profileRes = await ApiService.getProfile(widget.token);
      if (profileRes['data'] == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                Profile(token: widget.token, userId: res['data']['user']['id']),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Notacceptedyet(),
          ),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('بانتظار موافقة الإدارة')),
        // );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['error']['otp'] ?? 'OTP غير صالح')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 400,
              child: Image.asset("images/damas.jpg", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 290,
            child: Container(
              height: 320,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 40),

                  Container(
                    height: 30,
                    width: 300,
                    child: Text(
                      " Enter your verification code :",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F7F7),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      // what i changed
                      controller: otpController, // ✅ هذا هو الحل
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        label: Text(
                          "Your Code",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey[500],
                        ),
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final otp = otpController.text.trim();
                        if (otp.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('⚠️ الرجاء إدخال رمز التحقق'),
                            ),
                          );
                          return;
                        }

                        handleVerify(); // ← phone لازم يكون واصل للصفحة
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
