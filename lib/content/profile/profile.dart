import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/onboard/widgets/asset_card.dart';
import 'package:kibasi/onboard/widgets/bordered_avatar.dart';
import 'package:kibasi/onboard/widgets/custom_list.dart';
import 'package:kibasi/onboard/widgets/subtitle.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
              height: 10,
            ),
            _content(),
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
              '@Kilimanjaro_Express',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: color.AppColor.paleBlue,
          onTap: () {
            //Place a modal bottom sheet hear
          },
          child: Icon(
            Icons.menu,
            size: 25,
            color: color.AppColor.paleBlue,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Icon(
          Icons.notifications_none,
          size: 25,
          color: color.AppColor.paleBlue,
        ),
      ],
    );
  }

  Widget _content() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            _profile(),
            SizedBox(
              height: 30,
            ),
            _accountDetails(),
            SizedBox(
              height: 30,
            ),
            _assetDetails(),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Profile Photo
        Stack(
          children: [
            Hero(
              tag: "ProfileAvatar",
              child: _profileImage(
                  url: "assets/images/profile/profile.jpg",
                  status: color.AppColor.gold),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color.AppColor.gold,
                ),
                child: Icon(
                  Icons.star_outline,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        //Profile details
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Username
            Row(
              children: [
                Text(
                  'Jorge Steward',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //Verification
                Icon(
                  Icons.verified,
                  size: 15,
                  color: color.AppColor.blue,
                ),
              ],
            ),
            SizedBox(height: 5),
            //Role
            Text(
              'Manager',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //Subscription Button
            _subscriptionButton(),
          ],
        ),
      ],
    );
  }

  Widget _profileImage({required String url, required Color status}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: status,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 45,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(url),
      ),
    );
  }

  Widget _subscriptionButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: color.AppColor.paleBlue,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            size: 25,
            color: color.AppColor.gold,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'PREMIUM ACCOUNT',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _assets(),
        SizedBox(
          width: 15,
        ),
        _cashflow(),
      ],
    );
  }

  Widget _assets() {
    return Column(
      children: [
        //Buses
        _busContent(),
        SizedBox(
          height: 10,
        ),
        //Drivers
        _driverContent(),
      ],
    );
  }

  Widget _cashflow() {
    return Column(
      children: [
        //total cash
        _totalEarningsCard(),
        SizedBox(
          height: 10,
        ),
        //Power Up subscription plan
        _subscriptionExpiryCard(),
      ],
    );
  }

  Widget _subscriptionExpiryCard() {
    return Container(
      height: 100,
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.AppColor.blue,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.AppColor.paleBlue.withOpacity(0.2),
            offset: Offset(3, 4),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscription Expiry',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '5 days',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _subProgressBar(),
        ],
      ),
    );
  }

  Widget _subProgressBar() {
    return Container(
      height: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          value: 0.7,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          backgroundColor: Colors.white10,
        ),
      ),
    );
  }

  Widget _totalEarningsCard() {
    return Container(
      height: 220,
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.AppColor.paleBlue.withOpacity(0.2),
            offset: Offset(3, 4),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomList(title: 'Total Sales', value: 2890, isMoney: true),
          SizedBox(
            height: 6,
          ),
          CustomList(title: 'Total Bookings', value: 234),
          SizedBox(
            height: 6,
          ),
          CustomList(title: 'Total Travellers', value: 2890),
          SizedBox(
            height: 6,
          ),
          CustomList(title: 'Total Routes', value: 289),
        ],
      ),
    );
  }

  Widget _busContent() {
    return AssetCard(
      colorCard: color.AppColor.blue,
      cardID: 1,
      widget: Column(
        children: [
          CustomList(title: 'Active Buses', value: 10, widgetID: 1),
          CustomList(title: 'Inactive Buses', value: 0, widgetID: 1),
          CustomList(title: 'Total Buses', value: 10, widgetID: 1),
        ],
      ),
    );
  }

  Widget _driverContent() {
    return AssetCard(
      colorCard: Colors.white,
      cardID: 2,
      widget: Column(
        children: [
          CustomList(title: 'Active Drivers', value: 6, widgetID: 2),
          CustomList(title: 'Inactive Drivers', value: 1, widgetID: 2),
          CustomList(title: 'Total Drivers', value: 7, widgetID: 2),
        ],
      ),
    );
  }

  Widget _assetDetails() {
    var _data = [];
    _data.add(_assetContent(1));
    _data.add(_assetContent(2));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Subtitle(
          title: "Assets",
        ),
        SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _assetContent(1),
              SizedBox(width: 20),
              _assetContent(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _assetContent(int assetType) {
    return AssetCard(
      height: 130,
      width: 220,
      colorCard: Colors.white,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Subtitle(
            title: assetType == 1 ? "Owned Buses" : "Available Drivers",
          ),
          SizedBox(
            height: 20,
          ),
          assetType == 1 ? _buses() : _drivers(),
        ],
      ),
    );
  }

  Widget _drivers() {
    final items = [
      BorderedAvatar(
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile2.jpg",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile3.png",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile4.jpg",
          status: color.AppColor.disable,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile5.jpg",
          status: color.AppColor.disable,
          radius: 20),
      BorderedAvatar(
        url: "7",
        status: color.AppColor.paleBlue,
        isText: true,
        radius: 20,
      ),
    ];

    return _ownedAsset(items);
  }

  Widget _buses() {
    final items = [
      BorderedAvatar(
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile2.jpg",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile3.png",
          status: color.AppColor.green,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile4.jpg",
          status: color.AppColor.disable,
          radius: 20),
      BorderedAvatar(
          url: "assets/images/profile/profile5.jpg",
          status: color.AppColor.disable,
          radius: 20),
      BorderedAvatar(
        url: "10",
        status: color.AppColor.paleBlue,
        isText: true,
        radius: 20,
      ),
    ];

    return _ownedAsset(items);
  }

  Widget _ownedAsset(List<Widget> items) {
    return _overlapped(items);
  }

  Widget _overlapped(List<Widget> items) {
    final overlap = 25.0;

    List<Widget> stackLayers = List<Widget>.generate(items.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: items[index],
      );
    });

    return Stack(children: stackLayers);
  }
}
