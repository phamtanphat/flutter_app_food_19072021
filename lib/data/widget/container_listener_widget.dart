import 'package:flutter/cupertino.dart';
import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:provider/provider.dart';

class ContainerListenerWidget<T extends BaseBloc> extends StatefulWidget{
  final Widget child;
  final Function(BaseEvent event) callback;

  ContainerListenerWidget({required this.child, required this.callback});

  @override
  _ContainerListenerWidgetState createState() => _ContainerListenerWidgetState<T>();

}

class _ContainerListenerWidgetState<T> extends State<ContainerListenerWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = context.read<T>() as BaseBloc;
    bloc.progressStream.listen((event) {
        widget.callback(event);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseEvent?>(
      create: (_) => (context.read<T>() as BaseBloc).progressStream,
      initialData: null,
      updateShouldNotify: (prev, current) {
        return true;
      },
      child: Consumer<BaseEvent?>(
        builder: (context, event, child) {
          return Container(
            child: widget.child,
          );
        },
      ),
    );
  }
}