import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FlagLoading extends StatelessWidget {
  const FlagLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 30.0,
            top: 20.0,
            bottom: 20.0,
          ),
          child: SpinKitWave(color: Colors.white, size: 50.0),
        ),
      ],
    );
  }
}
