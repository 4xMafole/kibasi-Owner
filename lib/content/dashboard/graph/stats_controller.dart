import 'dart:math';

import 'package:get/get.dart';
import 'package:kibasi/content/dashboard/daily_stats.dart';
import 'package:kibasi/utils/date.dart';

enum GraphData { Sales, Buses, Drivers}

class StatController extends GetxController {

  Rx<GraphData> data = GraphData.Sales.obs;
  RxString todayStat = "".obs;
  RxString currentWeek = "".obs;

  RxList<DailyStatUiModel> dailyStatList = (List<DailyStatUiModel>.of([])).obs;

  RxBool displayNextWeekBtn = false.obs;

  //mock stat data is set to positive number, so the max value is initialize as negative
  int maxSection = -1;

  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  @override
  void onInit() {
    setCurrentWeek();
    super.onInit();
  }

  void resetMaxValue() {
    maxSection = -1;
  }

  void setCurrentWeek() async {
    selectedDate = DateTime.now();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setPreviousWeek() {
    selectedDate = selectedDate.subtract(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeek() {
    selectedDate = selectedDate.add(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeekButtonVisibility() {
    displayNextWeekBtn.value = !selectedDate.isSameDate(currentDate);
  }

  String getWeekDisplayDate(DateTime dateTime) {
    return '${AppDateUtils.firstDateOfWeek(dateTime).toFormatString('dd MMM')} - ${AppDateUtils.lastDateOfWeek(dateTime).toFormatString('dd MMM')}';
  }

  Future<void> getDailyStatList(DateTime dateTime) async {
    resetMaxValue();
    var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

    List<DailyStatUiModel> sectionStat = List.filled(7, defaultDailyStat);

    var today = DateTime.now();
    var todayPosition = DateTime.now().weekday - 1;

    for (var i = 0; i <= 6; i++) {
      var date = daysInWeek[i];

      var randomStat = randomInt(1000);

      sectionStat[i] = calculateDifference(date) < 1 ? DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: randomStat,
          isToday: today.isSameDate(date),
          isSelected: todayPosition == i,
          dayPosition: i) : DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: 0,
          isToday: false,
          isSelected: todayPosition == i,
          dayPosition: i);

      if (maxSection < randomStat) {
        maxSection = randomStat;
      }

      dailyStatList.assignAll(sectionStat);
    }
  }

  int randomInt(int max) {
    return Random().nextInt(1000) + 1;
  }

  void setSelectedDayPosition(int position) {
    dailyStatList.assignAll(getDailyListWithSelectedDay(
      dailyStatList.call(),
      position,
    ));
  }

  List<DailyStatUiModel> getDailyListWithSelectedDay(
      List<DailyStatUiModel> list, int position) {
    return list
        .map((e) => e.copyWith(isSelected: e.dayPosition == position))
        .toList();
  }

  double getStatPercentage(int time) {
    return getSectionStatPercentage(time);
  }

  double getSectionStatPercentage(int time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection;
    }
  }

  void onNextWeek() {
    setNextWeek();
  }

  void onPreviousWeek() {
    setPreviousWeek();
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

}