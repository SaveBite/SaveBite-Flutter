import 'package:flutter/material.dart';

class CustomLoadingindicator extends StatelessWidget {
  const CustomLoadingindicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: Color(0xff5EDA42),
          ),
        ),
      ),
    );
  }
}
