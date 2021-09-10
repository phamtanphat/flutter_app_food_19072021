import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/model/cart_model.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/cart/cart_bloc.dart';
import 'package:flutter_app_food/page/cart/cart_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';
import 'package:flutter_app_food/request/order_request.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        child: CartPageContainer(),
        providers: [
          Provider(create: (_) =>OrderRequest()),
          ProxyProvider<OrderRequest , OrderRepository>(
            create: (_) => OrderRepository(),
            update: (context , orderRequest , orderRepository){
              orderRepository!.updateOrderRequest(orderRequest);
              return orderRepository;
            },
          ),
          ChangeNotifierProxyProvider<OrderRepository,CartBloc>(
            create: (_) => CartBloc(),
            update: (context, orderRepo , bloc){
              bloc!.updateOrderRepository(orderRepo);
              return bloc;
            },
          )
        ],
        appBar: AppBar(
          title: Text("Cart"),
        ),
    );
  }
}

class CartPageContainer extends StatefulWidget {
  const CartPageContainer({Key? key}) : super(key: key);

  @override
  _CartPageContainerState createState() => _CartPageContainerState();
}

class _CartPageContainerState extends State<CartPageContainer> {
  late CartBloc bloc;
  String orderId = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<CartBloc>();
    bloc.eventSink.add(CartEventGetList());
    orderId = (ModalRoute.of(context)!.settings.arguments! as Map)["orderId"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: bloc.streamCartModel,
        initialData: null,
        child: Consumer<CartModel>(
          builder: (context , cartModel , child){
            if (cartModel == null){
              return SizedBox();
            }
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartModel.items.length,
                        itemBuilder: (lstContext, index) =>
                            _buildItem(cartModel.items[index], context)),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                          "Tổng tiền : " +
                              NumberFormat("#,###", "en_US")
                                  .format(cartModel.total) +
                              " đ",
                          style: TextStyle(fontSize: 25, color: Colors.white))),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange)),
                        child: Text("Confirm",
                            style: TextStyle(color: Colors.white, fontSize: 25)),
                      ))
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _buildItem(ProductModel productModel, BuildContext context) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(productModel.images![0].imageUrl,
                      width: 150, height: 120, fit: BoxFit.fill),
                ),
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
                        child: Text(productModel.foodName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(productModel.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {

                            },
                            child: Text("-"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(productModel.quantity.toString(),
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {

                            },
                            child: Text("+"),
                          ),
                        ],
                      )
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

