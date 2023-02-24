import 'package:finmaster/Screen/Login/user_info.dart';
import 'package:finmaster/provider/auth_provider.dart';
import 'package:finmaster/utils/utils.dart';
import 'package:finmaster/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(35.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/ver.jpg"),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Verification",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter the OTP send to your phone number",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.purple.shade200))),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: CustomButton(
                              text: "Verify",
                              onPressed: () {
                                if (otpCode != null) {
                                  verifyOtp(context, otpCode!);
                                } else {
                                  showSnackBar(context, "Enter 6-Digit Code");
                                }
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Didn't recieve any code?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Resend New Code?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {
          // check whether user exixts
          ap.checkUsers().then((value) async {
            if (value == true) {
              print("old user");
              // already user
            } else {
              print("new user");
              // new user
              Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UserIndo())
                      );
                  
            }
          });
        });
  }
}
