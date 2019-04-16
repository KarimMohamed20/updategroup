import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:updateproject/ui/ui.dart';

class AdressMap extends StatefulWidget {
  final Widget child;

  AdressMap({Key key, this.child}) : super(key: key);

  _AdressMapState createState() => _AdressMapState();
}

class _AdressMapState extends State<AdressMap> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int markerIdCounter = 0;
  static const LatLng _center = const LatLng(23.8859, 45.0792);
  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition = _center;
  bool cameraMoving = true;
  List<String> availaleAdress = List<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[googleMap(), buttons(), getAdressButton()],
      ),
    );
  }

  googleMap() {
    return GoogleMap(
      myLocationEnabled: true,
      markers: Set<Marker>.of(markers.values),
      mapType: _currentMapType,
      onMapCreated: onMapCreated,
      onCameraMove: onCameraMove,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 2.0,
      ),
      onCameraIdle: onCameraStop,
    );
  }

  buttons() {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 80,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FlatButton(
            color: Colors.white70,
            onPressed: _onMapTypeButtonPressed,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            // backgroundColor: Colors.green,
            child: const Icon(
              Icons.satellite,
              size: 25.0,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    );
  }

  getAdressButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: cameraMoving
              ? CircularProgressIndicator(
                  backgroundColor: Colors.lightGreen,
                )
              : Opacity(
                  opacity: .85,
                  child: UI.button(
                      context,
                      cameraMoving ? '' : 'إختر العنوان',
                      Colors.lightGreen,
                      cameraMoving ? null : Icons.location_on,
                      MediaQuery.of(context).size.width / 1.6,
                      50,
                      cameraMoving ? null : showAvailableAdresses),
                ),
        ));
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

//# center marker
  void onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    MarkerId markerId = MarkerId(markerIdVal());
    LatLng position = _center;
    Marker marker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      markers[markerId] = marker;
    });

    Future.delayed(Duration(seconds: 1), () async {
      GoogleMapController controller = await mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 7.0,
          ),
        ),
      );
    });
  }

  String markerIdVal({bool increment = false}) {
    String val = 'marker_id_$markerIdCounter';
    if (increment) markerIdCounter++;
    return val;
  }

  onCameraMove(CameraPosition position) {
    cameraMoving = true;
    _lastMapPosition = position.target;
    if (markers.length > 0) {
      MarkerId markerId = MarkerId(markerIdVal());
      Marker marker = markers[markerId];
      Marker updatedMarker = marker.copyWith(positionParam: _lastMapPosition);
      setState(() {
        markers[markerId] = updatedMarker;
      });
    }
  }

  Future<bool> codeAdress(LatLng pos) async {
    // try {
    //   UI.toast(context, "${pos.latitude}" + "  " + "${pos.longitude}");
    //   availaleAdress.clear();
    //   List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(pos.latitude, pos.longitude));
    //   addresses.forEach((adress) => availaleAdress.add(adress.addressLine));
    //   if (availaleAdress != null && availaleAdress.isNotEmpty) {
    //     new Future.delayed(const Duration(seconds: 2), () => UI.toast(context, "debug only" + addresses[0].addressLine));
    //   }
    //   return true;
    // } catch (e) {
    //   UI.toast(context, e.toString());
    //   print(e);
    //   return false;
    // }

    try {
      availaleAdress.clear();
      List<Address> addresses = await Geocoder.google('AIzaSyBCenTAp1-f5ZK3px7f3F8GgDiImegsl8A')
          .findAddressesFromCoordinates(Coordinates(pos.latitude, pos.longitude));
      addresses.forEach((adress) => availaleAdress.add(adress.addressLine));
      return true;
    } catch (e) {
      UI.toast(context, 'خطأ');
      print(e);
      return false;
    }
  }

  onCameraStop() async {
    await codeAdress(_lastMapPosition);
    try {
      setState(() {
        cameraMoving = false;
      });
    } catch (e) {}
  }

  showAvailableAdresses() {
    TextEditingController _adressController = TextEditingController();
    bool noAdress = true;

    if (availaleAdress == null || availaleAdress.isEmpty) {
      noAdress = true;
    } else {
      noAdress = false;
    }

    showDialog<String>(
        context: context,
        builder: (context) {
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'العناوين المتاحة',
                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.orange[600]),
                ),
                new Container(
                  child: new TextField(
                    maxLines: 1,
                    enabled: noAdress,
                    controller: _adressController,
                    decoration: new InputDecoration(
                      labelText: ' العنوان',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: noAdress
                      ? Text('لا يوجد عنواين متاحة في هذا الموقع برجاء الادخال يدويا')
                      : ListView.builder(
                          itemCount: availaleAdress.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(availaleAdress[index]),
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.orange[600],
                              ),
                              onTap: () {
                                _adressController.text = availaleAdress[index];
                              },
                            );
                          },
                        ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('الغاء'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('تأكيد'),
                  onPressed: () async {
                    if (_adressController.text.isEmpty || _adressController.text.length < 3) {
                      UI.toast(context, 'برجاء ادخال العنوان');
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context, _adressController.text);
                    }
                  })
            ],
          );
        });
  }
}
