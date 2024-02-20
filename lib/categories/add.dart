import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_guide/components/custombuttonauth.dart';
import 'package:firebase_guide/components/textformfield.dart';
import 'package:firebase_guide/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isLoading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  CollectionReference categories = // creating categoris collection
      FirebaseFirestore.instance.collection('categoris');

  Future<void> addCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await categories.add({
          'name': categoryController
              .text, //inside categoris collection we add name document with value categoryController.text
          'id': FirebaseAuth.instance.currentUser!.uid,
        });
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (route) => false,
        );
      } catch (e) {
        isLoading = false;
        print('error is $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text('Add Category'),
      ),
      body: Form(
        key: formState,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextForm(
                        hinttext: 'enter category name',
                        mycontroller: categoryController,
                        validator: (val) {
                          if (val == "") {
                            return 'can\'t be empty';
                          }
                        },
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButtonAuth(
                    title: 'Add',
                    onPressed: () async {
                      await addCategory();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
