import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/onboard/model/slider.dart';
import 'package:kibasi/onboard/widgets/slide_dots.dart';
import 'package:kibasi/onboard/widgets/slide_items/slide_item.dart';
import 'package:kibasi/utils/constants.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (_, i) => SlideItem(i),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                        child: InkWell(
                          onTap: () {
                            _currentPage == sliderArrayList.length - 1 ?
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false)
                                : _pageController.jumpToPage(_currentPage + 1);
                          },
                          child: Text(
                            _currentPage == sliderArrayList.length - 1 ? Constants.DONE : Constants.NEXT,
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: InkWell(
                          onTap: () {
                            if(_currentPage == 0){
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                            }
                          },
                          child: Text(
                            _currentPage == 0 ? Constants.SKIP : "",
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}
