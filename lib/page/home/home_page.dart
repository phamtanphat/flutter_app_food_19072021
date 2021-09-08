import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/data/share_pre/share_preference.dart';
import 'package:flutter_app_food/data/widget/container_listener_widget.dart';
import 'package:flutter_app_food/data/widget/loading_widget.dart';
import 'package:flutter_app_food/model/order_model.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/home/home_bloc.dart';
import 'package:flutter_app_food/page/home/home_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';
import 'package:flutter_app_food/repository/product_repository.dart';
import 'package:flutter_app_food/request/order_request.dart';
import 'package:flutter_app_food/request/product_request.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: HomePageContainer(),
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
        ChangeNotifierProxyProvider2<OrderRepository, ProductRepository,
            HomeBloc>(
          create: (context) => HomeBloc(),
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

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({Key? key}) : super(key: key);

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  late HomeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read();
    bloc.eventSink.add(HomeEventOrderCount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          StreamProvider.value(
            value: bloc.orderStream,
            catchError: (_, __) => null,
            initialData: null,
            child: Consumer<OrderModel>(
              builder: (context, orderModel, child) {
                if (orderModel == null) {
                  return IconButton(
                      icon: Icon(Icons.shopping_cart), onPressed: () {});
                }
                return Container(
                  margin: EdgeInsets.only(right: 10, top: 5),
                  child: Badge(
                      padding: EdgeInsets.all(10),
                      badgeContent: Text(orderModel.total.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      child: IconButton(
                          icon: Icon(Icons.shopping_cart), onPressed: () {})),
                );
              },
            ),
          )
        ],
      ),
      body: ContainerListenerWidget<HomeBloc>(
        callback: (event) {
          switch (event.runtimeType) {
            case HomeEventGetOrderSuccess:
            case HomeEventGetOrderNotInit:
              bloc.eventSink.add(HomeEventGetListProduct());
              break;
          }
        },
        child: LoadingWidget(
          bloc: bloc,
          child: Container(
            child: StreamProvider.value(
              initialData: null,
              value: bloc.listProductStream,
              child: Consumer<List<ProductModel>>(
                builder: (context, list, child) {
                  if (list == null) {
                    return SizedBox();
                  }
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildItemFood(list[index]);
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemFood(ProductModel product) {
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
                child: Image.network(product.images![0].imageUrl,
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
                        child: Text(product.foodName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(product.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {
                          bloc.eventSink.add(HomeEventAddCart(foodId: product.foodId!));
                        },
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
