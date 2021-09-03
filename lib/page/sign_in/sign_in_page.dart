import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/data/widget/button_widget.dart';
import 'package:flutter_app_food/data/widget/container_listener_widget.dart';
import 'package:flutter_app_food/data/widget/loading_widget.dart';
import 'package:flutter_app_food/page/sign_in/sign_in_bloc.dart';
import 'package:flutter_app_food/page/sign_in/sign_in_event.dart';
import 'package:flutter_app_food/repository/authentication_repository.dart';
import 'package:flutter_app_food/request/authentication_request.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign In",
        child: SignInContainer(),
        providers: [
          Provider(create: (_) => AuthenticationRequest()),
          ProxyProvider<AuthenticationRequest, AuthenticationRepository>(
            create: (_) => AuthenticationRepository(),
            update: (context , request , repository){
              repository!.updateAuthenticationRequest(request);
              return repository;
            },
          ),
          ChangeNotifierProxyProvider<AuthenticationRepository , SignInBloc>(
            create: (_) => SignInBloc(),
            update: (context , repo , bloc){
              bloc!.updateRepository(repo);
              return bloc;
            },
          )
        ],
        actions: []
    );
  }
}

class SignInContainer extends StatefulWidget {
  @override
  _SignInContainerState createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  var isPassVisible = true;
  late SignInBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerListenerWidget<SignInBloc>(
      callback: (event){
          switch(event.runtimeType){
            case SignInSuccess:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thành công")));
              break;
            case SignInFail:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((event as SignInFail).message)));
              break;
          }
      },
      child: SafeArea(
        child: LoadingWidget(
          bloc: bloc,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 2, child: Image.asset("assets/images/ic_hello_food.png")),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPhoneTextField(),
                        _buildPasswordTextField(),
                        _buildButtonSignIn(),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildTextSignUp())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account!"),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/sign-up");
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _passController,
        obscureText: isPassVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ButtonWidget(
          title: "Sign In",
          onPress: () {
            String email = _emailController.text;
            String password = _passController.text;
            bloc.eventSink.add(SignInEvent(email: email,password: password));
          },
        ));
  }
}
