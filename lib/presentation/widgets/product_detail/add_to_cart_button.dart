import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key, required this.onTap,this.isLoading=false}) : super(key: key);
  final VoidCallback onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading?(){}:onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isLoading?Colors.grey:Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child: isLoading?const Text(
            'Add to cart',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ):const CircularProgressIndicator(),
        ),
      ),
    );
  }
}