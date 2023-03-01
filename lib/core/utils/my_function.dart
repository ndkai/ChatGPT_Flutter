import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phuquoc/core/error/failures.dart';

import '../constants.dart';


// Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
//     BuildContext context, String assetName, Color color) async {
//   String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
//   //Draws string representation of svg to DrawableRoot
//   DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, svgString);
//   ui.Picture picture = svgDrawableRoot.toPicture(
//       size: Size(widthOfMarker, heightOfMarker),
//       colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
//   // colorFilter: ColorFilter.mode(color, BlendMode.modulate));
//   // ui.Image image = await picture.toImage(26, 37);
//   ui.Image image =
//       await picture.toImage(widthOfMarker.toInt(), heightOfMarker.toInt());
//
//   ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
//   return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
// }
//
// Future<LocationModel> getUserLocation() async {
//   GeolocationStatus geolocationStatus =
//       await Geolocator().checkGeolocationPermissionStatus();
//
//   Position position = await Geolocator()
//       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   debugPrint('location: ${position.latitude}');
//   final coordinates = new Coordinates(position.latitude, position.longitude);
//   print('coordinates is: $coordinates');
//
//   var addresses =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   var first = addresses.first;
// // print number of retured addresses
//   print('${addresses.length}');
// // print the best address
//   print("lolol ${first.featureName} : ${first.addressLine}");
//   return LocationModel(address: first.addressLine, lat: position.latitude, long: position.longitude);
// }
//
Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    BuildContext context, String assetName, Color color) async {
  String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
  //Draws string representation of svg to DrawableRoot
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, svgString);
  ui.Picture picture = svgDrawableRoot.toPicture(
      size: Size(120, 160),
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  // colorFilter: ColorFilter.mode(color, BlendMode.modulate));
  // ui.Image image = await picture.toImage(26, 37);
  ui.Image image = await picture.toImage(
      120, 160);

  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}


String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}


void changePageWithReplacement(BuildContext context, Widget page){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
}

void changePage(BuildContext context, Widget page){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}


String getImageByFileExtension(String extension){
  if(extension.contains("doc")){
    return "assets/files/doc.png";
  }  else
  if(extension.contains("xls")){
    return "assets/files/excel.png";
  } else
  if(extension.contains("jpg") || extension.contains("png")){
     return "assets/files/image.png";
  } else
  if(extension.contains("mp3")){
    return "assets/files/mp3.png";
  } else
  if(extension.contains("mp4")){
    return "assets/files/video.png";
  }
  return "assets/files/non_determine.png";
}


