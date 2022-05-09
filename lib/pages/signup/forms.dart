import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'signup_page.dart';

class Form1 extends GetView<SignupController> {
  const Form1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.detailsForm,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(height: 24),
          const SizedBox(height: 12),
          ReactiveTextField(
            formControlName: 'name',
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          ReactiveTextField(
            formControlName: 'contactNum',
            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              border: OutlineInputBorder(),
              labelText: "Contact Number",
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          ReactiveTextField(
            formControlName: 'cnic',
            decoration: const InputDecoration(
              icon: Icon(Icons.credit_card),
              border: OutlineInputBorder(),
              labelText: "CNIC",
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
