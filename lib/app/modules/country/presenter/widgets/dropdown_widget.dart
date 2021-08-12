import 'package:flutter/material.dart';

import '../../../../core/util/constants.dart';

class DropDown extends StatelessWidget {
  DropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        print(result);
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        ...REGIONS.map(_buildRegion).toList(),
      ],
      icon: Icon(Icons.more_vert, color: Colors.grey),
    );
  }

  PopupMenuItem<String> _buildRegion(String region) => PopupMenuItem<String>(
        value: region,
        child: Text(region),
      );
}
