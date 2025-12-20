import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/NotAcceptedYet.dart';
import 'package:flutter_project/view/MainRoutes/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/api/api_service.dart';

class Profile extends StatefulWidget with ChangeNotifier {
  final String token;
  final int userId;
  // final String phone;

   Profile({required this.token, required this.userId, Key? key})
    : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdateController = TextEditingController();
  String imagePath = '';
  String idImagePath = '';

  Future<void> pickImage(bool isID) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        if (isID) {
          idImagePath = picked.path;
        } else {
          imagePath = picked.path;
        }
      });
    }
  }

  void handleSubmit() async {
    final res = await ApiService.createProfile(
      token: widget.token,
      userId: widget.userId,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      birthdate: birthdateController.text,
      imagePath: imagePath,
      idImagePath: idImagePath,
    );

    if (res['message']?.contains('exists') == true) {
      // what i changed
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Homepage(token: widget.token ,)));
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text('الملف موجود مسبقًا')));
    } else {
      // what i changed
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Notacceptedyet()));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('تم إرسال الطلب، بانتظار موافقة الإدارة')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 300,
              child: Image.asset("images/damas.jpg", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 500,
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Inter your information",
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
                    // First Name Field
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
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text(
                            "fist name",
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
                    SizedBox(height: 30),

                    // Last Name Field
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
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text(
                            "last name",
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
                    SizedBox(height: 30),

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
                      child:
                          // Password Field
                          TextField(
                            controller: birthdateController,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                "birthdate",
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
                    SizedBox(height: 30),

                    // Profile Image Picker
                    GestureDetector(
                      onTap: () => pickImage(/*ImageSource.gallery,*/ true),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: imagePath == null
                            ? Center(child: Text('Pick Profile Image'))
                            : Image.file(
                                File(imagePath),
                                height: 150,
                                width: 150,
                              ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // ID Image Picker
                    GestureDetector(
                      onTap: () => pickImage(/*ImageSource.gallery,*/ false),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: idImagePath == null
                            ? Center(child: Text('Pick ID Image'))
                            : Image.file(
                                File(idImagePath),
                                height: 150,
                                width: 150,
                              ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Submit Button
                    ElevatedButton(
                      onPressed: handleSubmit,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
