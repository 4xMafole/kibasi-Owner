import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/assets/dashbd_asset_page.dart';
import 'package:kibasi/content/dashboard/graph.dart' as graph;
import 'package:kibasi/content/models/min_card_model.dart';
import 'package:kibasi/content/profile/profile_page.dart';
import 'package:kibasi/content/subscription/components.dart';
import 'package:kibasi/widget/bordered_avatar.dart';
import 'package:kibasi/widget/custom_list.dart';
import 'package:kibasi/widget/subtitle.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:kibasi/widget/custom_card.dart' as card;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Stack(
          children: [
            _content(),
            _week(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        _mainDashboard(),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //username
                  Text(
                    "Hi, Mahes",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //role
                  Subtitle(title: "Tagine"),
                ],
              ),
              Expanded(child: Container()),
              InkWell(
                splashColor: color.AppColor.paleBlue,
                onTap: () {
                  Get.to(ProfilePage());
                },
                child: Hero(
                  tag: "ProfileAvatar",
                  child: BorderedAvatar(
                    radius: 30,
                    url: "assets/images/profile/profile.jpg",
                    status: subCommponent.isPro!
                        ? color.AppColor.blue
                        : subCommponent.isPremium!
                            ? color.AppColor.gold
                            : color.AppColor.purple,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _title(),
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          width: 70,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color.AppColor.blue,
          ),
        ),
      ],
    );
  }

  Widget _graphedDetails() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: card.AppCard().cardDecoration(),
      child: _graph(),
    );
  }

  Widget _graph() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: graph.Graph(context).build(),
    );
  }

  Widget _week() {
    return Stack(
      children: [
        graph.Graph(context).pageIndicatorText(),
        graph.Graph(context).previousWeekButton(),
        graph.Graph(context).nextWeekButton(),
      ],
    );
  }

  Widget _ticketDetails() {
    var _data = [];
    _data.add(MinCardModel(
        title: "Sold", imageUrl: "assets/icons/sold.png", number: 56));
    _data.add(MinCardModel(
        title: "Verified", imageUrl: "assets/icons/verified.png", number: 32));
    _data.add(MinCardModel(
        title: "Pending", imageUrl: "assets/icons/pending.png", number: 17));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Subtitle(
          title: "Ticket Details",
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return card.AppCard().minCard(_data[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _driverList() {
    var _data = [];
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(1));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(1));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile2.jpg",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(1));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile3.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(1));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile4.jpg",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(1));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile5.jpg",
          status: color.AppColor.disable),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Subtitle(
              title: "Driver List",
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Get.to(DashboardAssetPage(assetID: 1));
              },
              child: Text('View All',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.AppColor.paleBlue,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return _data[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _busList() {
    var _data = [];
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(0));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(0));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(0));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(0));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));
    _data.add(GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => _viewDialog(0));
      },
      child: BorderedAvatar(
          radius: 30,
          url: "assets/images/profile/profile1.png",
          status: color.AppColor.disable),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Subtitle(
              title: "Bus List",
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Get.to(DashboardAssetPage(assetID: 0));
              },
              child: Text('View All',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.AppColor.paleBlue,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return _data[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _mainDashboard() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            _graphedDetails(),
            const SizedBox(
              height: 30,
            ),
            _ticketDetails(),
            const SizedBox(
              height: 30,
            ),
            _driverList(),
            const SizedBox(
              height: 30,
            ),
            _busList(),
          ],
        ),
      ),
    );
  }

  Widget _viewDialog(int assetIndex) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 350,
        child: assetIndex == 0 ? _busDialog() : _driverDialog(),
      ),
    );
  }

  Widget _driverDialog() {
    double dialogWidth = 280;
    double titleFontSize = 16;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Driver',
            value: 'Jorge Steward',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Bus',
            value: 'DTZ 1920 (Kilimanjaro Express)',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Journey',
            value: 'Dar es Salaam - Arusha',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Route',
            value: 'Bagamoyo',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Bookings',
            value: '34',
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _busDialog() {
    double dialogWidth = 280;
    double titleFontSize = 16;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Bus',
            value: 'DTZ 1920 (Kilimanjaro Express)',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Driver',
            value: 'Jorge Steward',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Journey',
            value: 'Dar es Salaam - Arusha',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Route',
            value: 'Bagamoyo',
          ),
          SizedBox(
            height: 16,
          ),
          CustomList(
            width: dialogWidth,
            titleSize: titleFontSize,
            title: 'Bookings',
            value: '34',
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
