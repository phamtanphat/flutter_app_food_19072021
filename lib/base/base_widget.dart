import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final List<SingleChildWidget> providers;
  AppBar? appBar;

  PageContainer({required this.child, required this.providers, this.appBar});

  @override
  Widget build(BuildContext context) {
    Widget shouldRenderPage() {
      if (providers.length > 0) {
        return MultiProvider(
          providers: [...providers],
          child: Scaffold(
            appBar: this.appBar == null ? null : this.appBar,
            body: child,
          ),
        );
      } else {
        return Scaffold(
          appBar: this.appBar == null ? null : this.appBar,
          body: child,
        );
      }
    }

    return shouldRenderPage();
  }
}
