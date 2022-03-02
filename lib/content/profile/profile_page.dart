import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/content/assets/views/asset_page.dart';
import 'package:kibasi/content/profile/edit_profile_page.dart';
import 'package:kibasi/content/subscription/components.dart';
import 'package:kibasi/content/subscription/owner_gate_page.dart';
import 'package:kibasi/utils/constants.dart';
import 'package:kibasi/utils/firebase/fire_auth/fire_auth.dart';
import 'package:kibasi/widget/asset_card.dart';
import 'package:kibasi/widget/bordered_avatar.dart';
import 'package:kibasi/widget/custom_list.dart';
import 'package:kibasi/widget/subtitle.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class ProfilePage extends StatelessWidget {
  User user;

  ProfilePage({required this.user});

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
            _appBar(context),
            SizedBox(
              height: 10,
            ),
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _appBar(context) {
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
            _menuSheet(context);
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
        InkWell(
          splashColor: color.AppColor.paleBlue,
          onTap: () {
            _notification(context);
          },
          child: Icon(
            Icons.notifications_none,
            size: 25,
            color: color.AppColor.paleBlue,
          ),
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
                url: "assets/images/avatar.png",
                status: subCommponent.isPro!
                    ? color.AppColor.blue
                    : subCommponent.isPremium!
                        ? color.AppColor.gold
                        : color.AppColor.purple,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: subCommponent.isPremium!
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: subCommponent.isPro!
                            ? color.AppColor.blue
                            : subCommponent.isPremium!
                                ? color.AppColor.gold
                                : color.AppColor.purple,
                      ),
                      child: Icon(
                        Icons.star_outline,
                        size: 25,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(),
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
                  '${user.displayName}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //Verification
                subCommponent.isVerified!
                    ? Icon(
                        Icons.verified,
                        size: 15,
                        color: color.AppColor.blue,
                      )
                    : Container(),
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
          width: 3,
          color: subCommponent.isPro!
              ? color.AppColor.blue
              : subCommponent.isPremium!
                  ? color.AppColor.gold
                  : color.AppColor.purple,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.star,
            size: 25,
            color: subCommponent.isPro!
                ? color.AppColor.blue
                : subCommponent.isPremium!
                    ? color.AppColor.gold
                    : color.AppColor.purple,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            subCommponent.isPro!
                ? 'PROFESSIONAL ACCOUNT'
                : subCommponent.isPremium!
                    ? 'PREMIUM ACCOUNT'
                    : 'TRIAL ACCOUNT',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 10,
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
    return GestureDetector(
      onTap: () {
        Get.to(OwnerGatePage());
      },
      child: Container(
        height: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: LinearProgressIndicator(
            value: 0.7,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: Colors.white10,
          ),
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
          CustomList(title: 'Total Sales', value: '2890', isMoney: true),
          SizedBox(
            height: 6,
          ),
          CustomList(
            title: 'Total Bookings',
            value: '234',
          ),
          SizedBox(
            height: 6,
          ),
          CustomList(
            title: 'Total Travellers',
            value: '2890',
          ),
          SizedBox(
            height: 6,
          ),
          CustomList(
            title: 'Total Routes',
            value: '289',
          ),
        ],
      ),
    );
  }

  Widget _busContent() {
    return AssetCard(
      colorCard: color.AppColor.blue,
      widget: Column(
        children: [
          CustomList(title: 'Active Buses', value: '10', widgetID: 1),
          CustomList(title: 'Inactive Buses', value: '0', widgetID: 1),
          CustomList(title: 'Total Buses', value: '10', widgetID: 1),
        ],
      ),
    );
  }

  Widget _driverContent() {
    return AssetCard(
      colorCard: Colors.white,
      widget: Column(
        children: [
          CustomList(title: 'Active Drivers', value: '6', widgetID: 2),
          CustomList(title: 'Inactive Drivers', value: '1', widgetID: 2),
          CustomList(title: 'Total Drivers', value: '7', widgetID: 2),
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
      InkWell(
        onTap: () {
          Get.to(AssetPage(assetID: Constants.DRIVER_ASSET));
        },
        child: BorderedAvatar(
          url: "7",
          status: color.AppColor.paleBlue,
          isText: true,
          radius: 20,
        ),
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
      InkWell(
        onTap: () {
          Get.to(AssetPage(assetID: Constants.BUS_ASSET));
        },
        child: BorderedAvatar(
          url: "10",
          status: color.AppColor.paleBlue,
          isText: true,
          radius: 20,
        ),
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

  _menuSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.person,
                        color: color.AppColor.paleBlue,
                      ),
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: color.AppColor.paleBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Get.to(const EditProfilePage());
                      }),
                  ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: color.AppColor.paleBlue,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: color.AppColor.paleBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        FireAuth.signOut();
                        Get.offAll(LoginPage());
                      }),
                ],
              ),
            ),
          );
        });
  }

  _notification(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
            child: DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: 5,
                      padding: EdgeInsets.all(16),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 30,
                        );
                      },
                      itemBuilder: (context, int index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: 30,
                          ),
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: color.AppColor.blue,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 10,
                                color: color.AppColor.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subcription Updates",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          84,
                                      child: Text(
                                        "Your Premium subscription plan will expiry in 5 days to come until 12th June 2022. If you would like to keep enjoying our services please update your plan. \n\n Unlock your plan NOW!",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: color.AppColor.textBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
