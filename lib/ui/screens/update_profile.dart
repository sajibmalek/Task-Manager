import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/auth_utility.dart';
import 'package:task_manager/ui/screens/bottom_nav_screen.dart';
import 'package:task_manager/widgets/reusable_background.dart';
import 'package:task_manager/widgets/user_profile_banner.dart';

import '../data/models/network_response.dart';
import '../utility/assets_utility/string_utility.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

XFile? imageFile;
ImagePicker imagePicker = ImagePicker();

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final userData = AuthUtility.userInfo.data;
  bool _profileInProgress = false;
  static const String _validMail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String _validNumber = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final _update_emailController = TextEditingController(  );
  final _update_firstNameController = TextEditingController();
  final _update_lastNameController = TextEditingController();
  final _update_mobileNumberController = TextEditingController();
  final _update_passwordController = TextEditingController();
  final _updateProfileFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _update_emailController.text = userData?.email ?? '';
    _update_firstNameController.text = userData?.firstName ?? '';
    _update_lastNameController.text = userData?.lastName ?? '';
    _update_mobileNumberController.text = userData?.mobile ?? '';

  }
  Future<void> updateProfile() async {
    _profileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _update_firstNameController.text.trim(),
      "lastName": _update_lastNameController.text.trim(),
      "mobile": _update_mobileNumberController.text.trim(),
      "photo": ""
    };
    if (_update_passwordController.text.isNotEmpty) {
      requestBody['password'] = _update_passwordController.text;
    }

    final NetworkResponse response =
    await NetWorkCaller().postRequest(ApiUrl.updateProfile, requestBody);
    _profileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userData?.firstName = _update_firstNameController.text.trim();
      userData?.lastName = _update_lastNameController.text.trim();
      userData?.mobile = _update_mobileNumberController.text.trim();
      AuthUtility.updateUserInfo(userData!);
      _update_passwordController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile updated!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile update failed! Try again.')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackGround(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const UserProfileAppBar(),
                  Form(
                    key: _updateProfileFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 0, right: 40, top: 30, bottom: 20),
                          child: const Text(
                            AppString.update_profile,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("upload")));
                                  selectImage();

                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 38),
                                  height: 40,
                                  width: 70,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.cloud_upload,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 200,
                                color: Colors.white,
                                child: Center(
                                  child: Text(imageFile?.name??''
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 310,
                          margin: const EdgeInsets.only(
                              left: 64, right: 35, bottom: 15),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return AppString.enter_email;
                              }
                              if (!RegExp(_validMail)
                                  .hasMatch(value.toString())) {
                                return AppString.enter_valid_email;
                              }
                              if (mounted) {
                                setState(() {});
                              }
                              return null;
                            },
                            controller: _update_emailController,
                            readOnly: true,
                            decoration: InputDecoration(
                                label: const Text("Email"),
                                prefixIconColor: Colors.green,
                                // prefixText: "*******",
                                hintText: "example@gmail.com",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.email,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          width: 310,
                          margin: const EdgeInsets.only(
                              left: 64, right: 35, bottom: 15),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return AppString.first_name;
                              }
                              if (mounted) {
                                setState(() {});
                              }
                              return null;
                            },
                            controller: _update_firstNameController,
                            decoration: InputDecoration(
                                label: const Text("First Name"),
                                prefixIconColor: Colors.green,
                                // prefixText: "*******",
                                hintText: "sajib",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          width: 310,
                          margin: const EdgeInsets.only(
                              left: 64, right: 35, bottom: 15),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return AppString.last_name;
                              }
                              if (mounted) {
                                setState(() {});
                              }
                              return null;
                            },
                            controller: _update_lastNameController,
                            decoration: InputDecoration(
                                label: const Text("Last Name"),
                                prefixIconColor: Colors.green,
                                // prefixText: "*******",
                                hintText: "A. Malek",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          width: 310,
                          margin: const EdgeInsets.only(
                              left: 64, right: 35, bottom: 15),
                          child: TextFormField(
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return AppString.enter_mobile_number;
                              }
                              if (!RegExp(_validNumber)
                                  .hasMatch(value.toString())) {
                                return AppString.enter_valid_number;
                              }
                              if (mounted) {
                                setState(() {});
                              }
                              return null;
                            },
                            controller: _update_mobileNumberController,
                            decoration: InputDecoration(
                                label: const Text("Mobile Number"),
                                prefixIconColor: Colors.green,
                                // prefixText: "*******",
                                hintText: "0171234xxxix",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.phone_android,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          width: 310,
                          margin: const EdgeInsets.only(
                              left: 64, right: 35, bottom: 15),
                          child: TextFormField(
                            obscureText: true,
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return AppString.enter_password_new;
                              }
                              // if (value!.length <= 8) {
                              //   return AppString.minimum_length;
                              // }
                              if (mounted) {
                                setState(() {});
                              }
                              return null;
                            },
                            controller: _update_passwordController,
                            decoration: InputDecoration(
                                filled: true,
                                focusColor: Colors.white,
                                label: const Text("Password"),
                                prefixIconColor: Colors.green,
                                // prefixText: "*******",
                                hintText: "********",
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.password,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 310,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_updateProfileFormKey.currentState!.validate()) {
                                    updateProfile();

                                  }
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomNavScreen()), (route) => false);
                                    if (mounted) {
                                      setState(() {});
                                    }

                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 68, right: 40),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 310,
                                  height: 40,
                                  child: const Center(
                                    child: Icon(
                                      Icons.navigate_next_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        Center(child: TextButton(onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomNavScreen()), (route) => false);
                        }, child: const Text("Go to Home Screen"),),)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectImage() {
    imagePicker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((XFile) {
      if (XFile != null) {
        imageFile = XFile;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }



}
