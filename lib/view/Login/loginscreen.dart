import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/view/MainRoutes/homepage.dart';
import 'package:flutter_project/view/Login/ProfileForm.dart';
import 'package:flutter_project/view/Login/VirifingPage.dart';
//import 'package:flutter_project/ProfileForm.dart';
import 'dart:io';
import 'package:flutter_project/api/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  void handleLogin() async {
    final res = await ApiService.login(phoneController.text);
    if (res['status'] == 'success') {
      final token = res['data']['token'];
      final status = res['data']['user']['status'];

      if (status == 'pending') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => virifingpage(token: token)),
        );
      } else if (status == 'verify') {
        final profileRes = await ApiService.getProfile(token);
        if (profileRes['data'] == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  Profile(token: token, userId: res['data']['user']['id']),
            ),
          );
        } else {
          ////////////////////////////////////////my changes
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage(token: token,)),
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('بانتظار موافقة الإدارة')),
          // );
        }
      } else if (status == 'approved') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage(token: token,)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['message'] ?? 'خطأ غير معروف')),
      );
    }
  }

  /* Future<void> loginUser(BuildContext context, String phoneNumber) async {
    final url = Uri.parse('https://ce11d9793c88.ngrok-free.app/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone_number': phoneNumber,
        }),
      );

      print('📥 Status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success' && data.containsKey('data')) {
          final user = data['data']['user'];
          final status = user['status'];
          final phone = user['phone_number'];
          final token = data['data']['token'];

          print('🔐 Token from backend: $token');
          print('👤 User status: $status');

          if (token == null || token.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('⚠️ لم يتم استلام التوكن من السيرفر')),
            );
            return;
          }

          if (status == 'pending') {
            // المستخدم لسه ما تحقق → نوديه على صفحة التحقق
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => virifingpage(
                  //phone: phone,
                  token: token,
                ),
              ),
            );
          } else if (status == 'verify') {
            // دخل الرمز صح → نوديه على البروفايل
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(
                 //phone: phoneNumber,
                  token: token,
                ),
              ),
            );
          } else if (status == 'approved') {
            // مفعل بالكامل → نوديه على الهوم
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(
                  phone: phoneNumber,
                  token: token,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('⚠️ حالة غير معروفة: $status')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('⚠️ الرد من السيرفر غير متوقع')),
          );
        }
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ غير مصرح - تحقق من التوكن أو الصلاحيات')),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ لم يتم العثور على المسار - تحقق من رابط الـ API')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ خطأ من السيرفر: ${response.statusCode}')),
        );
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠️ لا يوجد اتصال بالإنترنت')),
      );
    } on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠️ الرد من السيرفر غير قابل للفهم (JSON خطأ)')),
      );
    } catch (e) {
      print('❌ Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠️ حدث خطأ غير متوقع: $e')),
      );
    }
  }*/

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
                    "Login",
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
                      " Enter your  phone number :",
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          "Phone",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
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
                      child: const Text(
                        'Send',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        print('send in login');
                        ///What i changed
                         handleLogin();
                      },
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
