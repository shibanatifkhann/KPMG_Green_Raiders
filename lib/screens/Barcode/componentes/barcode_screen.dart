import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:excel/excel.dart';
import 'package:green_raiders/constants.dart';

class BarcodePage extends StatefulWidget {
  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  String _scanBarcode = '';


  List<String> ret = [];
  List<Widget> rett = [];

  Future<dynamic> getName(String barcode) async {
    var data = await rootBundle.load('assets/projectdb.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    List<String>lwnames = [], hgnames = [], names = [];
    List<int>lwratings = [], hgratings = [], ratings = [];
    int? rat;
    String? nam;
    for (var table in excel.tables.keys) {
      //print(table); //sheet Name
      //print(excel.tables[table]!.maxCols);
      //print(excel.tables[table]!.maxRows);
      int murad = 0;
      for (var row in excel.tables[table]!.rows) {
        if (murad <= 7) {
          murad++;
          //69
          continue;
        }
        //print("$row\n");
        Data? barcodee = row[row.length - 1];
        if (barcodee == null)continue;
        //print(barcode.value);

        Data? name = row[0];
        Data? rating = row[row.length - 2];
        if (barcodee.value == int.parse(barcode)) {
          nam = name!.value;
          rat = rating!.value;
        }
        names.add(name!.value);
        ratings.add(rating!.value);
      }
    }
    int cnt = 0;
    for (int x in ratings) {
      if (names[cnt] == nam) {
        cnt++;
        continue;
      }
      if (x > rat!) {
        hgnames.add(names[cnt]);
        hgratings.add(x);
      }
      else {
        lwnames.add(names[cnt]);
        lwratings.add(x);
      }
      cnt++;
    }


    ret = [];
    ret.add(nam! + ' $rat');

    if (hgratings.length == 0) {
      ret.add(lwnames[0] + ' ${lwratings[0]}');
      ret.add(lwnames[1] + ' ${lwratings[1]}');
      ret.add(lwnames[2] + ' ${lwratings[2]}');
      ret.add(lwnames[3] + ' ${lwratings[3]}');
    }
    else if (hgratings.length == 1) {
      ret.add(lwnames[0] + ' ${lwratings[0]}');
      ret.add(lwnames[1] + ' ${lwratings[1]}');
      ret.add(lwnames[2] + ' ${lwratings[2]}');
      ret.add(hgnames[0] + ' ${hgratings[0]}');
    }
    else if (lwratings.length == 1) {
      ret.add(hgnames[0] + ' ${hgratings[0]}');
      ret.add(hgnames[1] + ' ${hgratings[1]}');
      ret.add(hgnames[2] + ' ${hgratings[2]}');
      ret.add(lwnames[0] + ' ${lwratings[0]}');
    }
    else if (lwratings.length == 0) {
      ret.add(hgnames[0] + ' ${hgratings[0]}');
      ret.add(hgnames[1] + ' ${hgratings[1]}');
      ret.add(hgnames[2] + ' ${hgratings[2]}');
      ret.add(hgnames[3] + ' ${hgratings[3]}');
    }
    else {
      ret.add(hgnames[0] + ' ${hgratings[0]}');
      ret.add(hgnames[1] + ' ${hgratings[1]}');
      ret.add(lwnames[0] + ' ${lwratings[0]}');
      ret.add(lwnames[1] + ' ${lwratings[1]}');
    }

// print(ret);

    rett = [];
    for (String entry in ret) {
      rett.add(Text(entry,
        style: TextStyle(fontSize: 20),
      ),);
    }
    setState(() {

    });
  }



  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      getName(barcodeScanRes);
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(30),
                            width: 290,
                            decoration: BoxDecoration(border: Border.all(color: kTextColor, width: 3)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("Scan the product's barcode to see the list of similar products' ratings", style: TextStyle(color: kTextColor, fontSize: 30)),
                            ),
                        ),
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Container(child: Text('Start barcode scan', style: TextStyle(fontSize: 25))),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(20),
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              backgroundColor: Colors.green,

                            )
                        ),
                        Container(
                          // margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: rett,
                            ),
                          ),
                          // child: Column(children: ),
                          // decoration: BoxDecoration(border: Border.all(color: kTextColor)),
                        )
                      ]
                  )
              );
            })
        )
    );
  }
}