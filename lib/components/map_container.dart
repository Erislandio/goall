import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MapContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: MapOptions(
        boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(),
      ],
    );
  }
}
