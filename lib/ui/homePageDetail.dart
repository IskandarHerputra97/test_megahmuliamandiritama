import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_megahmuliamandiritama/model/people.dart';

class HomePageDetail extends StatefulWidget {

  People people;
  HomePageDetail({this.people});

  @override
  _HomePageDetailState createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {

  GoogleMapController mapController;
  LatLng _initialPosition;
  double _latitude;
  double _longitude;

  @override
  void initState() {

    setState(() {
      _latitude = double.parse(widget.people.latitude);
      _longitude = double.parse(widget.people.longitude);
      _initialPosition = LatLng(_latitude, _longitude);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage detail'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.green,
                width: 200,
                height: 200,
                child: FittedBox(
                  child: Image.network(widget.people.imagePath),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                color: Colors.blue[100],
                padding: EdgeInsets.all(18.0),
                width: 300,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.people.nama,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Nomor telepon',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.people.telepon,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.people.email,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      'Alamat',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.people.alamat,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                width: 400,
                height: 200,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 30.0),
            ],
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
}
