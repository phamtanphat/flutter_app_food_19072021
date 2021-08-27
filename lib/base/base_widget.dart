import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final List<SingleChildWidget> providers;
  final List<Widget> actions;

  PageContainer(
      {required this.title,
      required this.child,
      required this.providers,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    Widget shouldRenderPage() {
      if (providers.length > 0) {
        return MultiProvider(
          providers: [...providers],
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: actions,
            ),
            body: child,
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: actions,
          ),
          body: child,
        );
      }
    }

    return shouldRenderPage();
  }
}
