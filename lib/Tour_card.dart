import 'package:flutter/material.dart';
import 'package:flutter_gawlah/tour_view.dart';
import 'map.dart';

class TourCard extends StatelessWidget {
  final Map Tour;
  

  TourCard(this.Tour);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _crearContenedor(context),
      onLongPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TourView(image:Tour['image'],info:Tour['info'],
                )));
                
                
                print(Tour['info']);
                //PlacePolylinePage(
                     // tour_id: Tour['id'],
                      //centre: Tour['center'],
                   // )
                   // ));
                   
      },
      onTap: (){
 Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlacePolylinePage(
                     tour_id: Tour['id'],
                      centre: Tour['center'],
                   )
                   ));




      },
    );
  }

  Widget _crearContenedor(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        height: 700,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    offset: Offset(0.0, 10.0),
                    spreadRadius: 0,
                    blurRadius: 10)
              ]),
          child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _Hero(),
                  Column(
                    children: <Widget>[
                      Container(margin: EdgeInsets.only(top: 10)),
                      _crearHeader(),
                      Expanded(child: Container()),
                      createname(context),
                    ],
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }

  Widget _crearHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            children: <Widget>[
              
            ],
          ),
        ),
      ],
    );
  }

  Widget _Hero() {
    return Hero(
      child: Image.network(Tour['image'],fit: BoxFit.fill,),
      tag:Tour['image'] ,
    );
    
  }

  Widget createname(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Wrap(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                Tour['name'],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 37, color: Color.fromRGBO(230, 230, 230, .8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
