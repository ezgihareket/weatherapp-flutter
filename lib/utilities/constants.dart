import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontSize: 120.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontSize: 30.0,
);
const kdateStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontSize: 25.0,
);
const kdescStyle = TextStyle(
  fontFamily: 'Quicksand',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Quicksand',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
    size: 30,
  ),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide.none,
  ),
);
