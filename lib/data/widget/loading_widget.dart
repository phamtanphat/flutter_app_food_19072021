import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;

  LoadingWidget({
    required this.child,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading
                  ? Container(
                      width: 120,
                      height: 120,
                      decoration: new BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: SpinKitPouringHourglass(
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
