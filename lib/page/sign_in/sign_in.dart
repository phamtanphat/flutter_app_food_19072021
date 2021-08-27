import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/data/widget/container_listener_widget.dart';
import 'package:flutter_app_food/data/widget/loading_widget.dart';
import 'package:flutter_app_food/page/sign_in/sign_in_bloc.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign In",
        child: SignInPageContainer(),
        providers: [],
        actions: []);
  }
}

class SignInPageContainer extends StatefulWidget {

  @override
  _SignInPageContainerState createState() => _SignInPageContainerState();
}

class _SignInPageContainerState extends State<SignInPageContainer> {


  @override
  Widget build(BuildContext context) {
    return Consumer<SignInBloc>(
      builder: (context, bloc, child) {
        return LoadingWidget(
          bloc: context.read<SignInBloc>(),
          child: ContainerListenerWidget<SignInBloc>(
            callback: (event) {
              print(event.toString());
            },
            child: Container(
              child: Text("hello"),
            ),
          ),
        );
      },
    );
  }
}
