import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/bloc/product/product_bloc.dart';
import 'package:ecommerce/presentation/bloc/product/product_event.dart';
import 'package:ecommerce/presentation/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_background.dart';
import '../widgets/logout_button.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if(!authState.isLoggedIn){
          Navigator.of(context).pop();
        }
      },
      builder: (context, authState) {
        
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leadingWidth: 230,
              leading:  Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    (authState.isLoggedIn)?Text(
                      '${authState.currentUser!.name.firstname} ${authState.currentUser!.name.lastname}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ):const SizedBox(),
                  ],
                ),
              ),
              actions:  [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: authState.isLoading?const CircularProgressIndicator(): const LogOutButton(),
                ),
              ],
            ),
            body: AppBackground(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                  // TODO: implement listener
                }, builder: (context, state) {
                  if (state is ProductError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is! ProductsLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'Fake Store',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 15,),
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          itemBuilder: (context, index) => ProductCard(
                            productEntity: state.products[index],
                            isFavorite: true,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ));
      },
    );
  }
}
