import 'package:flutter/material.dart';
import 'package:flutter_app_food/base/base_widget.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/home/home_bloc.dart';
import 'package:flutter_app_food/page/home/home_event.dart';
import 'package:flutter_app_food/repository/product_repository.dart';
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
        ProxyProvider<ProductRequest , ProductRepository> (
          create: (context) => ProductRepository(),
          update: (context, request , repository){
            repository!.updateProductRequest(request);
            return repository;
          },
        ),
        ChangeNotifierProxyProvider<ProductRepository,HomeBloc>(
          create: (context) => HomeBloc(),
          update: (context , repository , bloc){
            bloc!.updateProductRepository(repository);
            return bloc;
          },
        )
      ],
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

  late HomeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read();
    bloc.eventSink.add(HomeEventGetListProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider.value(
        initialData: null,
        value: bloc.listProductStream,
        child: Consumer<List<ProductModel>>(
          builder: (context ,list , child){
            if (list == null){
              return SizedBox();
            }
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context , index){
                  return _buildItemFood(list[index]);
                }
            );
          },
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
                          // orderBloc
                          //     .add(OrderAddFoodEvent(foodId: foodModel.foodId));
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
