// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking/main.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';
import 'forget_password_view.dart';
import 'phone_number_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool rememberMe = false;
  final splashController = Get.find<SplashController>();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    rememberMe = box.read('remember') ?? false;

    if (rememberMe) {
      authController.emailController.text = box.read('email') ?? "";
    } else {
      box.remove('email');
      box.remove('password');

      authController.emailController.text = "";
      authController.passwordController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder:
          (authController) => Stack(
            children: [
              Scaffold(
                backgroundColor: AppColor.primaryBackgroundColor,
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: AppColor.primaryBackgroundColor,
                  leading: IconButton(
                    icon: SvgPicture.asset(
                      Images.back,
                      colorFilter: ColorFilter.mode(
                        AppColor.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.logo,
                              height: 60.h,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    // ignore: avoid_print
                                    print(authController.loader);
                                  },
                                  child: Text(
                                    'WELCOME_BACK'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 32.h,
                                    left: 16.w,
                                    right: 16.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('EMAIL'.tr, style: fontRegularBold),
                                      SizedBox(height: 4.h),
                                      TextFormField(
                                        controller:
                                            authController.emailController,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                              ).hasMatch(value)) {
                                            return "Enter valid email";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1.w,
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                  width: 1.w,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                          fillColor: Colors.red,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.r),
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColor.primaryColor,
                                              width: 1.w,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.r),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1.w,
                                              color: AppColor.dividerColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        'PASSWORD'.tr,
                                        style: fontRegularBold,
                                      ),
                                      SizedBox(height: 4.h),
                                      TextFormField(
                                        obscureText: passwordVisible,
                                        controller:
                                            authController.passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(
                                                r"^.{6,}",
                                              ).hasMatch(value)) {
                                            return "Password must be at least 6 charecter";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              width: 1.w,
                                              color: AppColor.primaryColor,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                  width: 1.w,
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                          fillColor: Colors.red,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.r),
                                            ),
                                            borderSide: BorderSide(
                                              color: AppColor.primaryColor,
                                              width: 1.w,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.r),
                                            ),
                                            borderSide: BorderSide(
                                              width: 1.w,
                                              color: AppColor.dividerColor,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: AppColor.gray,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                rememberMe = !rememberMe;
                                                if (rememberMe) {
                                                  box.write('remember', true);
                                                } else {
                                                  box.write('remember', false);
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  child:
                                                      rememberMe
                                                          ? SvgPicture.asset(
                                                            Images
                                                                .iconTickedYes,
                                                            fit: BoxFit.cover,
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                  AppColor
                                                                      .primaryColor,
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                          )
                                                          : SvgPicture.asset(
                                                            Images.iconTickedNo,
                                                            fit: BoxFit.cover,
                                                          ),
                                                ),
                                                SizedBox(width: 6.w),
                                                Text(
                                                  'REMEMBER_ME'.tr,
                                                  style: fontRegular,
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () =>
                                                    const ForgetPasswordView(),
                                                duration: const Duration(
                                                  milliseconds: 400,
                                                ),
                                                transition:
                                                    Transition.rightToLeft,
                                              );
                                            },
                                            child: Text(
                                              'FORGOT_PASSWORD'.tr,
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Rubik',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  authController.login(
                                                    authController
                                                        .emailController
                                                        .text,
                                                    authController
                                                        .passwordController
                                                        .text,
                                                  );
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColor.primaryColor,
                                              minimumSize: Size(292.w, 52.h),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                            ),
                                            child: Text(
                                              "LOGIN".tr,
                                              style: fontMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'DONT_HAVE_AN_ACCOUNT'.tr,
                                            style: TextStyle(
                                              color: AppColor.textSignupColor,
                                              fontSize: 14.sp,
                                              fontFamily: 'Rubik',
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => PhoneNumberView(
                                                  isGuest: false,
                                                ),
                                                duration: const Duration(
                                                  milliseconds: 400,
                                                ),
                                                transition:
                                                    Transition.rightToLeft,
                                              );
                                            },
                                            child: Text(
                                              'SIGN_UP'.tr,
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                                fontFamily: 'Rubik',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        splashController.configData.siteGuestLogin == 10
                            ? SizedBox()
                            : Padding(
                              padding: EdgeInsets.only(
                                bottom: 16.h,
                                left: 16.w,
                                right: 16.w,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: Text(
                                      'OR'.tr,
                                      style: TextStyle(
                                        color: AppColor.textSignupColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Rubik',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                () => PhoneNumberView(
                                                  isGuest: true,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.white,
                                              minimumSize: Size(290.w, 52.h),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 1.w,
                                                  color: AppColor.primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                            ),
                                            child: Text(
                                              "LOGIN_AS_GUEST".tr,
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontFamily: 'Rubik',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              authController.loader
                  ? Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white60,
                      child: const Center(child: LoaderCircle()),
                    ),
                  )
                  : const SizedBox.shrink(),
            ],
          ),
    );
  }
}
























//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:foodking/app/modules/splash/controllers/splash_controller.dart';
// import 'package:foodking/main.dart';
// import 'package:get/get.dart';
// import '../../../../util/constant.dart';
// import '../../../../util/style.dart';
// import '../../../../widget/loader.dart';
// import '../controllers/auth_controller.dart';
// import 'forget_password_view.dart';
// import 'phone_number_view.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:firebase_auth/firebase_auth.dart';
//
// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//
//   String? verificationId;
//   bool otpSent = false;
//   bool loading = false;
//   int? resendToken;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set language code for better SMS delivery
//     FirebaseAuth.instance.setLanguageCode('en');
//   }
//
//   void sendOtp() async {
//     if (phoneController.text.trim().isEmpty) {
//       showSnackBar('Please enter phone number');
//       return;
//     }
//
//     setState(() => loading = true);
//
//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '+91${phoneController.text.trim()}',
//         timeout: const Duration(seconds: 60),
//
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // Auto-verification (happens on some devices)
//           try {
//             await FirebaseAuth.instance.signInWithCredential(credential);
//             navigateToHome();
//           } catch (e) {
//             showSnackBar('Auto-verification failed: $e');
//           }
//         },
//
//         verificationFailed: (FirebaseAuthException e) {
//           setState(() => loading = false);
//           String message = 'Verification failed';
//
//           switch (e.code) {
//             case 'invalid-phone-number':
//               message = 'Invalid phone number format';
//               break;
//             case 'too-many-requests':
//               message = 'Too many requests. Please try again later';
//               break;
//             case 'app-not-authorized':
//               message = 'App not authorized for Firebase Auth';
//               break;
//             default:
//               message = 'Error: ${e.message}';
//           }
//
//           showSnackBar(message);
//         },
//
//         codeSent: (String verId, int? resendToken) {
//           setState(() {
//             verificationId = verId;
//             this.resendToken = resendToken;
//             otpSent = true;
//             loading = false;
//           });
//           showSnackBar('OTP sent successfully');
//         },
//
//         codeAutoRetrievalTimeout: (String verId) {
//           verificationId = verId;
//         },
//
//         forceResendingToken: resendToken,
//       );
//     } catch (e) {
//       setState(() => loading = false);
//       showSnackBar('Error sending OTP: $e');
//     }
//   }
//
//   void verifyOtp() async {
//     if (otpController.text.trim().isEmpty) {
//       showSnackBar('Please enter OTP');
//       return;
//     }
//
//     setState(() => loading = true);
//
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId!,
//         smsCode: otpController.text.trim(),
//       );
//
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       navigateToHome();
//     } on FirebaseAuthException catch (e) {
//       setState(() => loading = false);
//
//       String message = 'Invalid OTP';
//       switch (e.code) {
//         case 'invalid-verification-code':
//           message = 'Invalid OTP code';
//           break;
//         case 'session-expired':
//           message = 'OTP expired. Please request a new one';
//           break;
//         default:
//           message = 'Verification failed: ${e.message}';
//       }
//
//       showSnackBar(message);
//     } catch (e) {
//       setState(() => loading = false);
//       showSnackBar('Error: $e');
//     }
//   }
//
//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   // void navigateToHome() {
//   //   setState(() => loading = false);
//   //   showSnackBar('Login Successful!');
//   //
//   //   // Get the current user
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   if (user != null) {
//   //     print('User UID: ${user.uid}');
//   //     print('Phone Number: ${user.phoneNumber}');
//   //
//   //     Get.offAllNamed('/dashboard');
//   //
//   //     // Navigate to your home screen
//   //     // Navigator.pushReplacementNamed(context, '/home');
//   //   }
//   // }
//
//
//   void navigateToHome() async {
//     setState(() => loading = false);
//     showSnackBar('Login Successful!');
//
//     try {
//       // Get the current Firebase user
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user != null) {
//         print('User UID: ${user.uid}');
//         print('Phone Number: ${user.phoneNumber}');
//
//         // Get Firebase ID token
//         String? idToken = await user.getIdToken();
//         print(idToken);
//
//         // Call Laravel backend with ID token
//         final response = await http.post(
//           Uri.parse('https://ash.agrisciencecorporation.com/api/auth/firebase'),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $idToken', // ✅ send token in header
//           },
//
//         );
//
//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           print("Laravel User: ${data['user']}");
//
//           // Optionally store user data
//           // final box = GetStorage();
//           // box.write('user', data['user']);
//
//           // Navigate to dashboard
//           Get.offAllNamed('/dashboard');
//         } else {
//           print("Backend error: ${response.body}");
//           showSnackBar('Login failed: Unable to fetch user profile');
//         }
//       } else {
//         showSnackBar('Login failed: User not found');
//       }
//     } catch (e) {
//       print('Error in navigateToHome: $e');
//       showSnackBar('Something went wrong during login');
//     }
//   }
//
//   void resendOtp() {
//     setState(() {
//       otpSent = false;
//       otpController.clear();
//     });
//     sendOtp();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Phone Authentication'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: loading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Icon(
//               Icons.phone_android,
//               size: 80,
//               color: Colors.orange,
//             ),
//             const SizedBox(height: 30),
//
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               enabled: !otpSent,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 prefixText: '+91 ',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 prefixIcon: const Icon(Icons.phone),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             if (otpSent) ...[
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 6,
//                 decoration: InputDecoration(
//                   labelText: 'Enter OTP',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   prefixIcon: const Icon(Icons.lock),
//                   counterText: '',
//                 ),
//               ),
//               const SizedBox(height: 10),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: resendOtp,
//                     child: const Text('Resend OTP'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         otpSent = false;
//                         otpController.clear();
//                       });
//                     },
//                     child: const Text('Change Number'),
//                   ),
//                 ],
//               ),
//             ],
//
//             const SizedBox(height: 30),
//
//             ElevatedButton(
//               onPressed: otpSent ? verifyOtp : sendOtp,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text(
//                 otpSent ? 'Verify OTP' : 'Send OTP',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     phoneController.dispose();
//     otpController.dispose();
//     super.dispose();
//   }
// }