import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "",
        child: SplashPageContainer(),
        providers: [],
        actions: []
    );
  }
}

class SplashPageContainer extends StatefulWidget {
  const SplashPageContainer({Key? key}) : super(key: key);

  @override
  _SplashPageContainerState createState() => _SplashPageContainerState();
}

class _SplashPageContainerState extends State<SplashPageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




