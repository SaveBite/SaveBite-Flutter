import 'package:flutter/material.dart';

Widget buildSearchBar(
    Color fillColor,
    double horizontal,
    double vertical,
    double fontsize,
    String hintText, {
      Function(String)? onChanged,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Material(
      // Add Material widget
      color: Colors.transparent, // Preserve the background
      child: TextField(
        autocorrect: true,
        style: TextStyle(color: Colors.grey[800], fontSize: fontsize),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xffCCCCCC), fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Color(0xffCCCCCC), size: 20),
          isDense: true, // Reduces overall vertical space
          contentPadding:
          EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xffEDE4E4)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xff5EDA42), width: 2),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xffEDE4E4), width: 1),
          ),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}