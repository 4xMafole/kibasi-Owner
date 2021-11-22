import 'package:flutter/material.dart';

class AssetPage extends StatelessWidget {
  final assetID; 

  const AssetPage({required this.assetID})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Asset Page'),
      ),
    );
  }
}
