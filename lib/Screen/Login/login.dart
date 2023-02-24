import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  // ignore: non_constant_identifier_names
  Country SelectedCountry = Country(phoneCode: "91", countryCode: "IN", e164Sc: 0, geographic: true, level: 1, name: "India", example: "India", displayName: "India", displayNameNoCountryCode: "IN", e164Key: "");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(35.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.shade50,
                ),
                child: Image.asset("assets/login.webp"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Register",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Add your phone number. We'll send you a verification code",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.purple,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12)),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                    onTap: (){},
                    child: Text("${SelectedCountry.flagEmoji}"),
                    ),
                  ),

                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
