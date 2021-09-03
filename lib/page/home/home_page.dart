import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Home",
        child: HomePageContainer(),
        providers: [],
        actions: []
    );
  }
}

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({Key? key}) : super(key: key);

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

