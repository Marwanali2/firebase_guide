import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_guide/components/custombuttonauth.dart';
import 'package:firebase_guide/components/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.docId, required this.oldName});
  final String docId;
  final String oldName;
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  bool isLoading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController newNameController = TextEditingController();
  CollectionReference categories = // creating categoris collection
      FirebaseFirestore.instance.collection('categoris');
// set-->update if document exist
// set-->add if document doesn't exist
  Future<void> editCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await categories.doc(widget.docId).set({
          'name': newNameController.text,
        }, SetOptions(merge: true));
        // SetOptions(merge: true)) لو انا عدلت الاسم لكن محطتش الاي دي هلاقي  الاسم اتعدل لكن الاي دي هيتحذف و بالتالي كده التعديل ميسمع عندي عشان كده بعمل السيت ميرج بترو عشان التعديل يظهر حتي و الاي دي ميتحذفش حتي لو انا مبعتوش
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
  void dispose() {
    newNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    newNameController.text = widget.oldName;
    super.initState();
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
        title: const Text('Edit Category'),
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
                        hinttext: 'enter category new name',
                        mycontroller: newNameController,
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
                    title: 'Edit',
                    onPressed: () async {
                      await editCategory();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
