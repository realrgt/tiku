import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'flag_loading_widget.dart';

class FlagDisplay extends StatelessWidget {
  const FlagDisplay({
    Key? key,
    required this.flag,
  }) : super(key: key);

  final String flag;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomRight: Radius.circular(3.0),
        topRight: Radius.circular(2.0),
        bottomLeft: Radius.circular(2.0),
      ),
      child: SvgPicture.network(
        flag,
        width: 200,
        height: 100,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => FlagLoading(),
      ),
    );
  }
}
