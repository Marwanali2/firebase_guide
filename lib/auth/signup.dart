// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_guide/components/custombuttonauth.dart';
import 'package:firebase_guide/components/customlogoauth.dart';
import 'package:firebase_guide/components/textformfield.dart';
import 'package:firebase_guide/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text("SignUp",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("SignUp To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  validator: (p0) {},
                  hinttext: "ُEnter Your username",
                  mycontroller: username),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  validator: (p0) {},
                  hinttext: "ُEnter Your Email",
                  mycontroller: email),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  validator: (p0) {},
                  hinttext: "ُEnter Your Password",
                  mycontroller: password),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                      },
                      child: const Text(
                        "Verify Email",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  // ignore: use_build_context_synchronously
                  if (FirebaseAuth.instance.currentUser!.emailVerified) {
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    showSnackBar(
                        context: context,
                        label: 'please verify email first',
                        backgroundColor: Colors.red);
                  }
                  await FirebaseAuth.instance.currentUser!
                      .sendEmailVerification();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    // ignore: use_build_context_synchronously
                    showSnackBar(
                        label: 'The password provided is too weak.',
                        backgroundColor: Colors.red,
                        context: context);
                  } else if (e.code == 'email-already-in-use') {
                    showSnackBar(
                        label: 'The account already exists for that email.',
                        backgroundColor: Colors.red,
                        context: context);
                  } else if (e.code == 'invalid-email') {
                    showSnackBar(
                        label: 'The email address is badly formatted.',
                        backgroundColor: Colors.red,
                        context: context);
                  }
                } catch (e) {
                  print(e);
                }
              }),
          Container(height: 20),

          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
