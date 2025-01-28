import 'package:flutter/material.dart';

import '../../../../widgets/form_field_widget.dart';
import '../../../../widgets/screen_width_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  String? errorEmailValue;
  final GlobalKey<FormState> emailKey = GlobalKey();

  String? errorPasswordValue;
  final GlobalKey<FormState> passwordKey = GlobalKey();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool _isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text("Sign Up",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                reverse: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      //
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      FormFieldWidget(
                        focusNode: emailFocusNode,
                        fieldKey: emailKey,
                        controller: emailTextEditingController,
                        obscureText: false,
                        validator: (value) {
                          final bool emailPatternValid = RegExp(
                                  r"^(?:[a-zA-Z0-9]+@iitmandi\.ac\.in|[a-zA-Z0-9]+@students\.iitmandi\.ac\.in)$")
                              .hasMatch(value!);
                          if (!emailPatternValid) {
                            return "Please enter a valid IIT Mandi email address.";
                          } else if (!_isEmailValid) {
                            return "Invalid IIT Mandi email address.";
                          }
                          return null;
                        },
                        onChanged: (String? value) {},
                        keyboardType: TextInputType.text,
                        errorText: errorEmailValue,
                        prefixIcon: Icons.lock_outline_rounded,
                        showSuffixIcon: true,
                        hintText: "Confirm Password",
                        textInputAction: TextInputAction.done,
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      FormFieldWidget(
                        focusNode: passwordFocusNode,
                        fieldKey: passwordKey,
                        controller: passwordTextEditingController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password.";
                          }
                          return null;
                        },
                        onChanged: (String? value) {},
                        keyboardType: TextInputType.text,
                        errorText: errorPasswordValue,
                        prefixIcon: Icons.lock_outline_rounded,
                        showSuffixIcon: true,
                        hintText: "Password",
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '* ',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor)),
                        TextSpan(
                            text:
                                "This will be your new password and updating the password can be done via some logged in device only.",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontFamily: 'Montserrat_Regular'))
                      ])),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                    ]),
              ),
              Positioned(
                bottom: 20,
                child: ScreenWidthButton(
                  text: "Update Password",
                  buttonFunc: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
