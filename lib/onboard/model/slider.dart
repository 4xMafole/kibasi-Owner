import 'package:kibasi/utils/constants.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider(
      {required this.sliderImageUrl,
      required this.sliderHeading,
      required this.sliderSubHeading});
}

final sliderArrayList = [
    Slider(
        sliderImageUrl: 'assets/images/slider_1.png',
        sliderHeading: Constants.SLIDER_HEADING_1,
        sliderSubHeading: "Tracking ticket transactions has never been easy before. Stay updated on realtime bookings right on your hand."),
    Slider(
        sliderImageUrl: 'assets/images/slider_2.png',
        sliderHeading: Constants.SLIDER_HEADING_2,
        sliderSubHeading: "Simplicity and intuitive navigation within the platform. We value your time."),
    Slider(
        sliderImageUrl: 'assets/images/slider_3.png',
        sliderHeading: Constants.SLIDER_HEADING_3,
        sliderSubHeading: "Stay connected with all your workers. Move with your company on your hand."),
  ];
