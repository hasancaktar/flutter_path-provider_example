import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //oluşacak dosyanın klasör yolu
  var mytextController = TextEditingController();

  Future<String> get getklasorYolu async {
    Directory klasor = await getApplicationDocumentsDirectory();
    debugPrint("klasor pathi : " + klasor.path);
    return klasor.path;
  }

  //dosya oluştur
  Future<File> get dosyaOlustur async {
    var olusturulacakDosyaninKlasorununYolu = await getklasorYolu;
    return File(olusturulacakDosyaninKlasorununYolu + "/mydosya.txt");
  }

  //dosya okuma işlemleri
  Future<String> dosyaOku() async {
    try {
      var myDOsya = await dosyaOlustur;
      String dosyaIcerigi = await myDOsya.readAsString();
      return dosyaIcerigi;
    } catch (exception) {
      return "Hata : $exception";
    }
  }

  //dosya yazma işlemleri
  Future<File> dosyayaYazz(String yazilacakString) async {
    var myDOSya = await dosyaOlustur;
    return myDOSya.writeAsString(yazilacakString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dosya işlemleri"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: mytextController,
                maxLines: 4,
                decoration: InputDecoration(hintText: "Yaz koçum"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: _dosyayaYaz,
                  color: Colors.blue,
                  child: Text("Yaz"),
                ),
                RaisedButton(
                  onPressed: _dosyadanOku,
                  color: Colors.blue,
                  child: Text("Oku"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _dosyayaYaz() {
    dosyayaYazz(mytextController.text.toString());
  }

  void _dosyadanOku() async {
    debugPrint(await dosyaOku());

    //ikinci Yöntem
    //dosyaOku().then((value) => debugPrint(value));
  }
}
