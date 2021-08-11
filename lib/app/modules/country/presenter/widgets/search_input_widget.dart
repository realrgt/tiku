import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 14.0, top: 15.0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: 'Código',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
