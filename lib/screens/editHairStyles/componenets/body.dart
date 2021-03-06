import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/screens/editHairStyles/componenets/edit_hairStyles_form.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  HairStyles hairstyles;
  Body({required this.hairstyles});
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                EditHairStylesForm(
                  hairstyles: widget.hairstyles,
                )
              ])
            ])));
  }
}
