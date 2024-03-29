import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/data/widget/button_widget.dart';
import 'package:flutter_app_food/data/widget/container_listener_widget.dart';
import 'package:flutter_app_food/data/widget/loading_widget.dart';
import 'package:flutter_app_food/page/sign_up/sign_up_bloc.dart';
import 'package:flutter_app_food/page/sign_up/sign_up_event.dart';
import 'package:flutter_app_food/repository/authentication_repository.dart';
import 'package:flutter_app_food/request/authentication_request.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (_) => AuthenticationRequest()),
        ProxyProvider<AuthenticationRequest, AuthenticationRepository>(
          create: (_) => AuthenticationRepository(),
          update: (context , request , repository){
            repository!.updateAuthenticationRequest(request);
            return repository;
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationRepository , SignUpBloc>(
          create: (_) => SignUpBloc(),
          update: (context , repo , bloc){
            bloc!.updateAuthenticationRepository(repo);
            return bloc;
          },
        )
      ],
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      child: SignUpPageContainer(),
    );
  }
}

class SignUpPageContainer extends StatefulWidget {
  @override
  _SignUpPageContainerState createState() => _SignUpPageContainerState();
}

class _SignUpPageContainerState extends State<SignUpPageContainer> {
  final _displayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late SignUpBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<SignUpBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerListenerWidget<SignUpBloc>(
      callback: (event){
        switch(event.runtimeType){
          case SignUpSuccess :
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng ký thành công")));
             Navigator.pop(context);
            break;
          case SignUpFail :
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((event as SignUpFail).message)));
            break;
        }
      },
      child: LoadingWidget(
        bloc: bloc,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 2, child: Image.asset("assets/images/ic_hello_food.png")),
                Expanded(
                    flex: 4,
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildDisplayTextField(),
                                  SizedBox(height: 10),
                                  _buildAddressTextField(),
                                  SizedBox(height: 10),
                                  _buildEmailTextField(),
                                  SizedBox(height: 10),
                                  _buildPhoneTextField(),
                                  SizedBox(height: 10),
                                  _buildPasswordTextField(),
                                  SizedBox(height: 10),
                                  _buildButtonSignUp()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _displayController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Example : Mr. John",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.person, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildAddressTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _addressController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Example : district 1",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.map, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Email : abc@gmail.com",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.email, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Phone ((+84) 123 456 789)",
          fillColor: Colors.black12,
          filled: true,
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
          prefixIcon: Icon(Icons.phone, color: Colors.blue),
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
        obscureText: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "Pass word",
          fillColor: Colors.black12,
          filled: true,
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
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignUp() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Center(child: ButtonWidget(title: "Sign Up", onPress: () {

        String fullName = _displayController.text;
        String email = _emailController.text;
        String phone = _phoneController.text;
        String password = _passController.text;
        String address = _addressController.text;

        if (fullName.length > 0 && email.length > 0 && phone.length > 0 && password.length > 0 && address.length > 0 ){
          bloc.eventSink.add(SignUpEvent(fullName: fullName, email: email, phone: phone, password: password, address: address));
        }

      })),
    );
  }
}
