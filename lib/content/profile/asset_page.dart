import 'package:flutter/material.dart';

class AssetPage extends StatelessWidget {
  final int assetID; 

  AssetPage({required this.assetID})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Asset Page'),
      ),
    );
  }
}
