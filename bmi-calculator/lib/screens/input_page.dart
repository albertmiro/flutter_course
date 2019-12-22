import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../calculator_brain.dart';
import '../constants.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../components/round_icon_button.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                buildMaleCard(),
                buildFemaleCard(),
              ],
            ),
          ),
          buildSliderCard(context),
          Expanded(
            child: Row(
              children: <Widget>[
                buildWeightCard(),
                buildAgeCard(),
              ],
            ),
          ),
          buildBottomButton(context)
        ],
      ),
    );
  }

  BottomButton buildBottomButton(BuildContext context) {
    return BottomButton(
      buttonTitle: 'CALCULATE',
      onTap: () {
        CalculatorBrain calculatorBrain =
            CalculatorBrain(height: height, weight: weight);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              bmiResult: calculatorBrain.calculateBMI(),
              resultText: calculatorBrain.getResult(),
              interpretation: calculatorBrain.getInterpretation(),
            ),
          ),
        );
      },
    );
  }

  Expanded buildAgeCard() {
    return Expanded(
      child: ReusableCard(
        colour: kActiveCardColour,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'AGE',
              style: kLabelTextStyle,
            ),
            Text(
              age.toString(),
              style: kNumberTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundIconButton(
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    setState(() {
                      if (age < 200) age++;
                    });
                  },
                ),
                SizedBox(width: 10.0),
                RoundIconButton(
                  icon: FontAwesomeIcons.minus,
                  onPressed: () {
                    setState(() {
                      if (age > 0) age--;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded buildWeightCard() {
    return Expanded(
      child: ReusableCard(
        colour: kActiveCardColour,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WEIGHT',
              style: kLabelTextStyle,
            ),
            Text(
              weight.toString(),
              style: kNumberTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundIconButton(
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    setState(() {
                      if (weight < 200) weight++;
                    });
                  },
                ),
                SizedBox(width: 10.0),
                RoundIconButton(
                  icon: FontAwesomeIcons.minus,
                  onPressed: () {
                    setState(() {
                      if (weight > 0) weight--;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded buildSliderCard(BuildContext context) {
    return Expanded(
      child: ReusableCard(
        colour: kActiveCardColour,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'HEIGHT',
              style: kLabelTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  height.toString(),
                  style: kNumberTextStyle,
                ),
                Text(
                  'cm',
                  style: kLabelTextStyle,
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                thumbColor: Color(0xFFEB1555),
                activeTrackColor: Colors.white,
                inactiveTrackColor: Color(0xFF8D8E98),
                overlayColor: Color(0x29EB1555),
              ),
              child: Slider(
                value: height.toDouble(),
                min: 90.0,
                max: 220.0,
                onChanged: (double newValue) {
                  setState(() {
                    height = newValue.round();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildFemaleCard() {
    return Expanded(
      child: ReusableCard(
        onPress: () {
          setState(() {
            selectedGender = Gender.female;
          });
        },
        colour: selectedGender == Gender.female
            ? kActiveCardColour
            : kInactiveCardColour,
        cardChild: IconContent(
          label: 'FEMALE',
          icon: FontAwesomeIcons.venus,
        ),
      ),
    );
  }

  Expanded buildMaleCard() {
    return Expanded(
      child: ReusableCard(
        onPress: () {
          setState(() {
            selectedGender = Gender.male;
          });
        },
        colour: selectedGender == Gender.male
            ? kActiveCardColour
            : kInactiveCardColour,
        cardChild: IconContent(
          label: 'MALE',
          icon: FontAwesomeIcons.mars,
        ),
      ),
    );
  }
}
