import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/repository/product_repository.dart';
import 'package:flutter_app_food/request/product_request.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: HomePageContainer(),
      providers: [],
      appBar: AppBar(
        title: Text("Product"),
      ),
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
  void didUpdateWidget(covariant HomePageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    ProductRepository repository = ProductRepository();
    repository.updateProductRequest(ProductRequest());
    repository.getListProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
