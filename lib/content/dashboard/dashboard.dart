import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/dashboard/graph.dart' as graph;
import 'package:kibasi/content/models/min_card_model.dart';
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
        padding: const EdgeInsets.all(20),
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          _mainDashboard(),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
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
              _subTitle("Tagine"),
            ],
          ),
          Expanded(child: Container()),
          _profileImage(
              url: "assets/images/profile/profile.jpg",
              status: color.AppColor.paleBlue),
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

  Widget _subTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
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
        _subTitle("Ticket Details"),
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
    _data.add(_profileImage(
        url: "assets/images/profile/profile1.png",
        status: color.AppColor.disable));
    _data.add(_profileImage(
        url: "assets/images/profile/profile2.jpg",
        status: color.AppColor.disable));
    _data.add(_profileImage(
        url: "assets/images/profile/profile3.png",
        status: color.AppColor.disable));
    _data.add(_profileImage(
        url: "assets/images/profile/profile4.jpg",
        status: color.AppColor.disable));
    _data.add(_profileImage(
        url: "assets/images/profile/profile5.jpg",
        status: color.AppColor.disable));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subTitle("Driver List"),
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

  Widget _profileImage({required String url, required Color status}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: status,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(url),
      ),
    );
  }

  Widget _mainDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        _title(),
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
      ],
    );
  }
}
