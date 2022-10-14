import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutocompleteBasicExample extends StatefulWidget {
  static const List<String> _kOptions = <String>[
    '을지로4가',
    '을지로3가',
    '을지로입구',
    '시청',
    '충정로',
    '합정',
    '홍대입구',
    '충무로',
    '사당',
    '로컬스티치',
    '로컬스티치합정'
  ];

  @override
  State<AutocompleteBasicExample> createState() =>
      _AutocompleteBasicExampleState();
}

class _AutocompleteBasicExampleState extends State<AutocompleteBasicExample> {
  late String subwayName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text('onPressed1')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, subwayName );
                    },
                    child: Text('onPressed1')),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Text(
                    'data',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.all(50),
                    child: Container(
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          subwayName = textEditingValue.text;

                          return AutocompleteBasicExample._kOptions.where(
                                  (String option) => option.contains(
                                  textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (String selection) {
                          debugPrint('You just selected $selection');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}