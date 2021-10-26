import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

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
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(height: 20,),
            _title(),
            SizedBox(height: 30,),
            _graphedDetails(),
          ],
        ),
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
              SizedBox(height: 5,),
              //role
              Text(
                "Tagine",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color.AppColor.paleBlue,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
          ),
        ],
      ),
    );
  }

 Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color.AppColor.paleBlue.withOpacity(0.14),
            offset: Offset(2, 4),
            spreadRadius: 3,
            blurRadius: 20,
          ),
          BoxShadow(
            color: color.AppColor.paleBlue.withOpacity(0.14),
            offset: Offset(-4, -2),
            spreadRadius: 3,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          _graphHeader(),
          SizedBox(height: 10,),
          // _graphSketch(),
        ],
      ),
    );
 }

  Widget _graphHeader() {
    return Row(
      children: [
        Text(
          "Tagine",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

}
