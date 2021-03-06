import 'package:flutter/material.dart';
import 'package:product_app/models/models.dart';
import 'package:provider/provider.dart';

import 'package:product_app/screens/screens.dart';
import 'package:product_app/services/services.dart';
import 'package:product_app/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    final authService = Provider.of<AuthServices>(context);

    if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            }),
      ),
      body: ListView.builder(
          itemCount: productService.product.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: ProductCard(
                  product: productService.product[index],
                ),
                onTap: () {
                  productService.selectedProduct =
                      productService.product[index].copy();

                  Navigator.pushNamed(context, 'product');
                },
              )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            productService.selectedProduct =
                new Product(available: false, name: '', price: 0);

            Navigator.pushNamed(context, 'product');
          }),
    );
  }
}
