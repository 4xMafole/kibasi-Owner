import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:kibasi/widget/asset_card.dart';
import 'package:kibasi/widget/bordered_avatar.dart';

class AssetPage extends StatefulWidget {
  final int assetID;

  AssetPage({required this.assetID});

  @override
  State<AssetPage> createState() => _AssetPageState(assetID);
}

class _AssetPageState extends State<AssetPage> {
  late List<String> _assets;
  late int _assetIndex;

  _AssetPageState(this._assetIndex);

  @override
  void initState() {
    super.initState();
    _assets = ["Buses", "Drivers"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _appBar(),
            SizedBox(
              height: 15,
            ),
            _assetChips(),
            _assetIndex == 0 ? _busContent() : _driverContent(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        InkWell(
          splashColor: color.AppColor.paleBlue,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: color.AppColor.paleBlue,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'ASSETS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _assetChips() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height / 15,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: _assets.length,
        itemBuilder: (context, int index) {
          return ChoiceChip(
            label: Text(_assets[index]),
            padding: EdgeInsets.all(10),
            selected: _assetIndex == index,
            selectedColor: color.AppColor.blue,
            onSelected: (bool selected) {
              setState(() {
                _assetIndex = selected ? index : 0;
              });
            },
            backgroundColor: color.AppColor.paleBlue,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _driverContent() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            padding: EdgeInsets.all(20),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(3, (index) {
              return AssetCard(
                padding: 10,
                colorCard: Colors.white,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BorderedAvatar(
                          url: "assets/images/profile/profile1.png",
                          status: color.AppColor.green,
                          radius: 20,
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.more_vert,
                          size: 20,
                          color: color.AppColor.paleBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Jorge Steward',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'DER T0132',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kilimanjaro Exp. 01',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }

  Widget _busContent() {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
            padding: EdgeInsets.all(20),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(7, (index) {
              return AssetCard(
                padding: 10,
                colorCard: Colors.white,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BorderedAvatar(
                          url: "assets/images/profile/profile1.png",
                          status: color.AppColor.green,
                          radius: 20,
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.more_vert,
                          size: 20,
                          color: color.AppColor.paleBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kilimanjaro Exp. 01',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'DER T0132',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Seat: ' + '20',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          'Price: ' + '20,000/=',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
