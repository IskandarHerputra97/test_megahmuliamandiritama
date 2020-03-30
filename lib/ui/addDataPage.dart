import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:test_megahmuliamandiritama/main.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  String searchAddress;

  final _formKey = GlobalKey<FormState>();

  GoogleMapController mapController;

  Position position;
  LatLng _initialPosition = LatLng(-6.2034987, 106.8293654);

  static final String uploadEndPoint =
      'http://$myIP/MegahMuliaMandiriTama/uploadImage.php';
  Future<File> file;
  File file2;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error uploading image';
  String fileName;

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });

    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      'image': base64Image,
      'name': fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (snapshot.hasError) {
          return const Text(
            'Error picking image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No image selected',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add data page'),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Nama',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input nama' : null,
                  controller: name,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Nomor telepon',
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Tolong input nomor telepon' : null,
                  controller: phoneNumber,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Email',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input email' : null,
                  controller: email,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Foto',
                ),
                OutlineButton(
                  onPressed: chooseImage,
                  child: Text('Choose image'),
                ),
                SizedBox(height: 20.0),
                showImage(),
                SizedBox(height: 20.0),
                OutlineButton(
                  onPressed: startUpload,
                  child: Text('Upload image'),
                ),
                SizedBox(height: 20.0),
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Alamat',
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Tolong input alamat' : null,
                  controller: address,
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 400,
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onMapCreated: onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    getMyPosition();
                  },
                  child: Text(
                    'Use my location',
                  ),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate() && fileName != null) {
                      _addData();
                      print('button press+filename : $fileName');
                      Navigator.of(context).pushNamedAndRemoveUntil('/homePage', (Route<dynamic> route) => false);
                    }
                    print(fileName);
                    print(position);
                    print(position.latitude);
                    print(position.longitude);
                  },
                  child: Text(
                    'Add data',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  getMyPosition() async {
    position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 20.0,
        )
    ));
  }

  _addData() {
    var url = 'http://$myIP/MegahMuliaMandiriTama/addData.php';

    http.post(url, body: {
      'nama': name.text,
      'telepon': phoneNumber.text,
      'email': email.text,
      'alamat': address.text,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'imagePath': 'http://$myIP/MegahMuliaMandiriTama/$fileName',
    });
    print(name.text);
    print(phoneNumber.text);
    print(email.text);
    print(address.text);
    print('http://$myIP/MegahMuliaMandiriTama/$fileName');
  }
}
