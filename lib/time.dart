import 'dart:math' show cos,sin,pi,acos;

String distance(
          double lat1, double lon1, double lat2, double lon2, String unit) {
         double theta = lon1 - lon2;
         double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
         cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
         dist = acos(dist);
         dist = rad2deg(dist);
         dist = dist * 60 * 1.1515;
          if (unit == 'K') {
            dist = dist * 1.609344;
          } else if (unit == 'N') {
            dist = dist * 0.8684;
          }
          return dist.toStringAsFixed(2);
        }

    double deg2rad(double deg) {
      return (deg * pi / 180.0);
    }

    double rad2deg(double rad) {
      return (rad * 180.0 / pi);
    }

    void main() {
      print("Distance in Kilo : " + distance(29.9547748, 31.2731292, 29.9877832,31.4421633,'K'));
    }