import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/app_styles.dart';

class ShowWelcomeMessage extends StatelessWidget {
  final String WelcomeMessage;
  final String authMessage;

  ShowWelcomeMessage(
      {this.WelcomeMessage = 'Create Account',
      this.authMessage = 'Its free and easy to set up!'});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Text(WelcomeMessage,style: AppStyles.styleMedium23,),
          Text(authMessage,style: AppStyles.styleRegular16,)
        ],
      ),
    );
  }
}
