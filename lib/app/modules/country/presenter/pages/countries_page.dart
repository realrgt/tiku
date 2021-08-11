import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class CountriesPage extends StatelessWidget {
  const CountriesPage({Key? key}) : super(key: key);

  Widget _buildBody() {
    return ListView(
      children: [
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: SearchInput(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Placeholder(fallbackHeight: 45.0),
        ),
        SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: CountryCard(),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Matiku'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.light_mode),
          )
        ],
      ),
      body: _buildBody(),
    );
  }
}
