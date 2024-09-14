import 'package:flutter/cupertino.dart';
import 'package:googlebookapi/pages/homePage.dart';

class AppRoutes {
  static const homePage = '/homePage';

  static Map<String, WidgetBuilder> define(){
    return{
      homePage: (BuildContext context) => const HomePage(),
      // taskList: (BuildContext context) => const TaskList(),
    };
  }
}