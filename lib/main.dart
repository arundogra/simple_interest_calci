import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//Main Function
void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SICalculator(),
    theme: ThemeData(
      primaryColor: Colors.pinkAccent,
      accentColor: Colors.pinkAccent,
    ),
  )
  );
}

//Stateful widget
class SICalculator extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SICalculator();
  }
}

class _SICalculator extends State<SICalculator> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollar', 'Ponds'];
  var selectedCurrency = '';
  final miniPadding = 5.0;

  @override
  void initState() {
    super.initState();
    selectedCurrency = _currencies[0];
  }

  var output = '';

  TextEditingController pricipalController = TextEditingController();
  TextEditingController rateOfInterestController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SimpleInterest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(miniPadding),
            child: ListView(
              children:<Widget> [
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(top: miniPadding, bottom: miniPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: pricipalController,
                    // ignore: missing_return
                    validator: (String value) {
                      if(value.isEmpty) {
                        return'Enter a vaild Principal value';
                      }
                    },
                    decoration: InputDecoration(
                        hintText:  'Enter amount eg:- 10000',
                        labelText: 'Principle',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: miniPadding, bottom: miniPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: rateOfInterestController,
                    // ignore: missing_return
                    validator: (String value) {
                      if(value.isEmpty) {
                        return'Enter a vaild Rate Of Interest';
                      }
                    },
                    decoration: InputDecoration(
                        hintText:  'Enter Rate Of Interest',
                        labelText: 'Rate Of Interest',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: miniPadding, bottom: miniPadding),
                  child: Row(
                    children: <Widget> [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termController,
                          // ignore: missing_return
                          validator: (String value) {
                            if(value.isEmpty) {
                              return'Enter a vaild Rate Of Interest';
                            }
                          },
                          decoration: InputDecoration(
                              hintText:  'Enter Term',
                              labelText: 'Term',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: miniPadding * 5,
                      ),

                      Expanded(
                        child: DropdownButton<String> (
                          items: _currencies.map((String dropDownStrinItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStrinItem,
                              child: Text(dropDownStrinItem),
                            );
                          }).toList(),
                          value: selectedCurrency,
                          onChanged: (String newStateSelected) {
                            _selectedValue(newStateSelected);
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(miniPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).canvasColor,
                          child: Text('Calculate'),
                          onPressed: () {
                            setState(() {
                              if(_formKey.currentState.validate()) {
                                this.output = _calculateReturns();
                              }
                            });
                          },
                        ),
                      ),

                      Container(
                        width: miniPadding * 2,
                      ),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).canvasColor,
                          textColor: Theme.of(context).accentColor,
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(miniPadding),
                  child: Text(this.output),
                ),

              ],
            )),
      ),
    );
  }

  //GetImageAsset importing image to our project
  Widget getImageAsset() {
    AssetImage assetImage =AssetImage('assets/images/calci.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(
        child: image,
        margin: EdgeInsets.all(miniPadding * 10)
    );
  }

  //Function for currency update
  void _selectedValue(String newStateSelected) {
    setState((){
      this.selectedCurrency = newStateSelected;
    });
  }

  //Arithmetic calculation function
  String _calculateReturns() {
    double principal =double.parse(pricipalController.text);
    double rateOfInterest =double.parse(rateOfInterestController.text);
    double term =double.parse(termController.text);

    double finalAmmount = principal + ( principal * rateOfInterest * term ) / 100;

    String result = 'After $term Years Investment Will Be Approx $finalAmmount $selectedCurrency';
    return result;
  }

  //Reset function
  void _reset() {
    pricipalController.text = '';
    rateOfInterestController.text = '';
    termController.text = '';
    output = '';
    selectedCurrency = _currencies[0];
  }

}


