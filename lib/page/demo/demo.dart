import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/demo/demo_bloc.dart';
import 'package:flutter_app_food/page/demo/demo_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';
import 'package:flutter_app_food/repository/product_repository.dart';
import 'package:flutter_app_food/request/order_request.dart';
import 'package:flutter_app_food/request/product_request.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: DemoContainer(),
      providers: [
        Provider(create: (context) => ProductRequest()),
        Provider(create: (context) => OrderRequest()),
        ProxyProvider<ProductRequest, ProductRepository>(
          create: (context) => ProductRepository(),
          update: (context, request, repository) {
            repository!.updateProductRequest(request);
            return repository;
          },
        ),
        ProxyProvider<OrderRequest, OrderRepository>(
          create: (context) => OrderRepository(),
          update: (context, request, repository) {
            repository!.updateOrderRequest(request);
            return repository;
          },
        ),
        ChangeNotifierProxyProvider2<OrderRepository,
            ProductRepository,
            DemoBloc>(
          create: (context) => DemoBloc(),
          update: (context, orderRepository, productRepository, bloc) {
            bloc!.updateProductRepository(productRepository);
            bloc.updateOrderRepository(orderRepository);
            return bloc;
          },
        )
      ],
    );
  }
}

class DemoContainer extends StatefulWidget {
  const DemoContainer({Key? key}) : super(key: key);

  @override
  State<DemoContainer> createState() => _DemoContainerState();
}

class _DemoContainerState extends State<DemoContainer> {
  late DemoBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<DemoBloc>();
    bloc.eventSink.add(FetchOrderEvent());
    bloc.eventSink.add(FetchOrderEvent2());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product"),
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
        ),
        body: Column(
          children: [
            StreamProvider<String>.value(
              value: bloc.textData,
              initialData: "",
              child: Consumer<String>(
                builder: (context , data , child){
                  return Text(data);
                },
              ),
            ),

            StreamProvider<String>.value(
              value: bloc.textData2,
              initialData: "",
              child: Consumer<String>(
                builder: (context , data , child){
                  return Text(data);
                },
              ),
            ),

          ],
        ));
  }

  Widget _buildItemFood() {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/images/icon_cookie.jpg",
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text("Abc",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US").format(10000000) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                        Text("Add To Cart", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
