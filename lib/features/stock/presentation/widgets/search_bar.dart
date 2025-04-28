import 'package:flutter/material.dart';

Widget buildSearchBar(Color fillColor, double horizontal, double vertical,
    double fontsize, String hintText,
    {Function(String)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextField(
        autocorrect: true,
        style: TextStyle(color: Colors.grey[800], fontSize: fontsize),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xffCCCCCC), fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Color(0xffCCCCCC), size: 20),
          isDense: true,
          // Reduces overall vertical space
          contentPadding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          // Controls height
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Color(0xffEDE4E4))),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Color(0xff5EDA42), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Color(0xffEDE4E4), width: 1),
          ),
        ),
        onChanged: onChanged),
  );
}
