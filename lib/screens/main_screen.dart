import 'package:la_boutique_de_a_y_s_app/screens/upload_product_form.dart';
import 'package:flutter/material.dart';

import 'top_app_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [TopBarScreen()],
    );
  }
}
