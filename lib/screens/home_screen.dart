import 'package:flutter/material.dart';
import 'package:miles_to_kilo/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> measure = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces',
  ];
  String _startMeasure;
  String _convertMeasure;
  double _numberFrom;
  String _result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Converter"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Value",
            style: kTextStyle,
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter to convert', hintStyle: kTextStyle),
              onChanged: (value) {
                setState(() {
                  _numberFrom = double.parse(value);
                });
              },
            ),
          ),
          Spacer(),
          Text(
            "From",
            style: kTextStyle,
          ),
          Spacer(),
          //DropDownMenu Item
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton(
                hint: Text(
                  'Select',
                  style: kTextStyle,
                ),
                isExpanded: true,
                dropdownColor: Colors.grey,
                value: _startMeasure,
                items: measure.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: kTextStyle,
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _startMeasure = value;
                  });
                }),
          ),
          Spacer(),
          Text(
            "To",
            style: kTextStyle,
          ),
          Spacer(),
          //DropDownMenuItem
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton(
              isExpanded: true,
              dropdownColor: Colors.grey,
              hint: Text(
                'Select',
                style: kTextStyle,
              ),
              value: _convertMeasure,
              items: measure.map(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: kTextStyle,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _convertMeasure = value;
                });
              },
            ),
          ),
          Spacer(
            flex: 2,
          ),
          MaterialButton(
            color: Colors.grey[900],
            onPressed: () {
              if (_startMeasure.isEmpty || _convertMeasure.isEmpty) {
                return;
              } else {
                _convert(_numberFrom, _startMeasure, _convertMeasure);
              }
            },
            child: Text(
              'Convert',
              style: kTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Text(
            (_result == null) ? '' : _result,
            style: kTextStyle,
          ),
          Spacer(flex: 1,)
        ],
      ),
    );
  }

  _convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _result = 'Conversion cannot Possible'.toLowerCase();
    } else {
      _result =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertMeasure';
      setState(() {
        _result = _result;
      });
    }
  }

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0], // 0 = > meter
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0], // 1 => kilometer
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274], // 2 => grams
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274], // 3 => kilograms
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0], //4 => feet
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0], //5 => miles
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16], //6 => pounds
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1], // 7 => ounces
  };
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
}
