import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/dashboard/daily_stats.dart';
import 'package:kibasi/content/dashboard/graph/stats_controller.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

enum GraphData { Sales, Buses, Drivers}

class Graph {
  BuildContext context;
  Graph(this.context);

  var statController = Get.put(StatController());
  GraphData? _data = GraphData.Sales;
  String _dataValue = "Sales";

  Widget build() {
    return Stack(
      children: [
        _buildGraphStat(),
        // _pageIndicatorText(),
        // _previousWeekButton(),
        // _nextWeekButton(),
      ],
    );
  }

  Widget _buildGraphStat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSectionTitle("Overview"),
        Obx(
              () => _buildWeekIndicators(statController.dailyStatList1.call(), 1),
        ),
      ],
    );
  }

  Widget _pageIndicatorText() {
    return Obx(() => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.blue,
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Text(
                statController.currentWeek.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        )));
  }

  Widget _previousWeekButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: RawMaterialButton(
          onPressed: () {
            statController.onPreviousWeek();
          },
          elevation: 2.0,
          fillColor: Colors.blue,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(8.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  Widget _nextWeekButton() {
    return Obx(
          () => Visibility(
        visible: statController.displayNextWeekBtn.value,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RawMaterialButton(
              onPressed: () {
                statController.onNextWeek();
              },
              elevation: 2.0,
              fillColor: Colors.blue,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8.0),
              shape: CircleBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,),
          ),
          Expanded(child: Container()),
          _toggleButton("Sales", GraphData.Sales),
          _toggleButton("Buses", GraphData.Buses),
          _toggleButton("Drivers", GraphData.Drivers),
        ],
      ),
    );
  }

  Widget _toggleButton(String name, GraphData toggleData) {
   return  Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Container(
            height: 10,
            width: 10,
            margin: EdgeInsets.only(right: 10),
            child: Radio(
              value: toggleData,
              activeColor: color.AppColor.blue,
              groupValue: _data,
              onChanged: (GraphData? value) {
                _data = value;
              },
            ),
          ),
        ),
        Text(name),
        SizedBox(width: 20,),
      ],
    );
  }

  Widget _buildWeekIndicators(List<DailyStatUiModel> models, int type) {
    if (models.length == 7) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildDayIndicator(models[0], type),
              _buildDayIndicator(models[1], type),
              _buildDayIndicator(models[2], type),
              _buildDayIndicator(models[3], type),
              _buildDayIndicator(models[4], type),
              _buildDayIndicator(models[5], type),
              _buildDayIndicator(models[6], type),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildDayIndicator(DailyStatUiModel model, int type) {
    const width = 14.0;
    return InkWell(
      onTap: () =>
          statController.setSelectedDayPosition(model.dayPosition, type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 48.0,
            height: 24.0,
            child: Visibility(
              visible: model.isSelected,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: color.AppColor.deepBlue,
                ),
                child: Center(
                  child: Text(
                      '${model.stat}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

          SizedBox(
            height: 4.0,
          ),
          Expanded(
            child: NeumorphicIndicator(
              width: width,
              percent: statController.getStatPercentage(model.stat, type),
            ),
          ),
          SizedBox(height: 8.0),
          DecoratedBox(
            decoration: _getDayDecoratedBox(model.isToday),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                model.day,
                style: TextStyle(
                  fontSize: 13,
                  color: model.isToday ? Colors.white : Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getDayDecoratedBox(bool isToday) {
    if (isToday) {
      return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: color.AppColor.label,
      );
    } else {
      return BoxDecoration();
    }
  }

}