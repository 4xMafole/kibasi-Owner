import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeEntryField extends StatefulWidget {
  String? title;
  TextEditingController? textInput;

  TimeEntryField({
    Key? key,
    required this.title,
    required this.textInput,
  }) : super(key: key);

  @override
  _TimeEntryFieldState createState() => _TimeEntryFieldState();
}

class _TimeEntryFieldState extends State<TimeEntryField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: widget.textInput!,
            readOnly: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                  builder: (context, child) {
                    return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: false,
                        ),
                        child: child!);
                  });

              if (pickedTime != null) {
                print(pickedTime.format(context)); //output 10:51 PM
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());
                //converting to DateTime so that we can further format on different pattern.
                print(parsedTime); //output 1970-01-01 22:53:00.000
                String formattedTime = DateFormat('hh:mm a').format(parsedTime);
                print(formattedTime); //output 01:26 AM
                //DateFormat() is from intl package, you can format the time on any pattern you need.

                setState(() {
                  widget.textInput!.text =
                      formattedTime; //set the value of text field.
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
