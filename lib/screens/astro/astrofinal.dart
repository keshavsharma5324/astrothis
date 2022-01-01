
/*import 'dart:async';


import 'package:astro/Model/Astro.dart';

import 'package:astro/screens/astro/astro_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Astrofinal extends StatefulWidget {
  Astro? Astromodel;
  Astrofinal({this.Astromodel});

  @override
  _AstrofinalState createState() => _AstrofinalState();
}

class _AstrofinalState extends State<Astrofinal> {
  DateTime currentDate = DateTime.now(); bool data = false; String searchString = "";
  FutureList<Data>? searchresults;
  String placeid = 'ChIJL_P_CXMEDTkRw0ZdG-0GVvw';
  String? month;int? day,monthnumber,year;
  String hintlocation = 'Delhi,India';TextEditingController location = TextEditingController();
  /*Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        month = formatter.format(pickedDate);
        day = pickedDate.day;
        monthnumber = pickedDate.month;
        year = pickedDate.year;
      });
    context.read<AstroCubit>().getAstro({"day":day,"month":monthnumber,"year":year,"placeId":placeid});
  }*/
  DateFormat formatter = DateFormat('MMMM');
  DateTime now = DateTime.now();

  @override
  void initState() {
    searchPlaces();
    day=currentDate.day;
    monthnumber = currentDate.month;
    year = currentDate.year;
    // TODO: implement initState
    super.initState();
    month = formatter.format(DateTime.now());
    context.read<AstroCubit>().getAstro();
    Timer(Duration(seconds: 3), () {
      setState(() {
        data = true;
      });
     
    });

  }
   searchPlaces() async {

   var search = await BlocProvider.of<AstroCubit>(context)!.fetchShows();
   searchresults = search.data!;//placesService.getAutocomplete(autcomplete);
    setState(() {
      searchresults;
    });
    // notifyListeners();
  }

 /* searchPlaces(String searchTerm) async {

   var search = await BlocProvider.of<AstroCubit>(context)!.getAutoCompletePlaces(searchTerm);
   searchresults = search.data!;//placesService.getAutocomplete(autcomplete);
    setState(() {
      searchresults;
    });
    // notifyListeners();
  }*/

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(body: SingleChildScrollView(child:Container(height: 900,color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

      Container(padding: EdgeInsets.symmetric(horizontal: 16),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [




        Column(children:[
          SizedBox(height: 50,),
          Container(height: 25,child:Image.asset('assets/hamburger.png'))]),
        Column(children:[
          SizedBox(height: 45,),
         // Text('ASTRO',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xff515152)),),
          Container(height: 40,child:Image.asset('assets/logo.png'))]),
        Column(children:[
          SizedBox(height: 50,),
          Container(height: 25,child:Image.asset('assets/profile.png'))]),
      ]),),SizedBox(height: 20,),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [SizedBox(width: 16,),Text('Talk to an Astrologer',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xff000000)),)],),
          Row(children: [
            Container(height: 20,child: Image.asset('assets/search.png')),SizedBox(width: 5,),Container(height: 20,child: Image.asset('assets/filter.png')),SizedBox(width: 5,),Container(height: 20,child: Image.asset('assets/sort.png')),SizedBox(width: 15,)
          ],)
        ],
      ),
       Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<Data>> snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(0),
                        itemCount: 10,//snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].firstName!
                              .toLowerCase()
                              .contains(searchString)
                              ? ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '${snapshot.data?[index].images!.medium}'),
                            ),
                            title: Text('${snapshot.data?[index].lastName}'),
                            subtitle: Text(
                                'Score: ${snapshot.data?[index].minimumCallDuration}'),
                          )
                              : Container();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].namePrefix!
                              .toLowerCase()
                              .contains(searchString)
                              ? Divider()
                              : Container();
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong :('));
                  }
                  return CircularProgressIndicator();
                },
                future: searchresults,
              ),
            ),
      
      data?
      Container(height: MediaQuery.of(context).size.height-160,
        child: ListView.builder(padding: EdgeInsets.all(0),
                  itemCount: widget.Astromodel!.data!.length,
                  itemBuilder: (contex, index) {
                    return Container(padding: EdgeInsets.only(left: 10),width: 150,child: InkWell(onTap: (){setState(() {
                      //placeid = searchresults![index].placeId.toString();
                      //context.read<PanchangCubit>().getpanchang({"day":day,"month":monthnumber,"year":year,"placeId":placeid});
                     // location.text= searchresults![index].placeName.toString();
                     // searchresults!.length = 0;
                      
                    });},
                      child: Column(
                        children: [SizedBox(height: 15,),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Container(padding: EdgeInsets.only(left: 6),width: 100,height: 90,child: Image.network(widget.Astromodel!.data![index].images!.medium!.imageUrl.toString(),fit: BoxFit.fitHeight,)),Container(width: MediaQuery.of(context).size.width-110,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('${widget.Astromodel!.data![index].firstName} ${widget.Astromodel!.data![index].lastName}',style: TextStyle(height: 1,fontSize: 16,fontWeight: FontWeight.w600,),),
                                  ),
                                   Padding(
                                     padding: const EdgeInsets.only(right: 16),
                                     child: Text('${widget.Astromodel!.data![index].experience!.round()} Years',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w400,),),
                                   ),
                                ],
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(Icons.person,size: 18,color: Color(0xfffa9244),),
                                  ),SizedBox(width: 7,),
                                   Container(width: MediaQuery.of(context).size.width/2,
                                     padding: const EdgeInsets.only(right: 16),
                                     child: Text('${widget.Astromodel!.data![index].aboutMe}',maxLines: 5,style: TextStyle(height: 1.3,fontSize: 14,fontWeight: FontWeight.w400,),),
                                   ),
                                  
                                   
                                ],
                              ),SizedBox(height: 4,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(Icons.language,size: 18,color: Color(0xfffa9244),)
                                  ),SizedBox(width: 7,),
                                  Row(
                                    children: [
                                      Padding(
                                         padding: const EdgeInsets.only(right: 0),
                                         child:  widget.Astromodel!.data![index].languages!.length>0?Text('${widget.Astromodel!.data![index].languages![0].name}',style: TextStyle(height: 1,fontSize: 14,fontWeight: FontWeight.w400,),):SizedBox(height: 0,),
                                       ),
                                        Padding(
                                         padding: const EdgeInsets.only(right: 0),
                                         child: widget.Astromodel!.data![index].languages!.length==2?Text(', ${widget.Astromodel!.data![index].languages![1].name}',style: TextStyle(height: 1,fontSize: 14,fontWeight: FontWeight.w400,),):SizedBox(height: 0,),
                                       ),
                                    ],
                                  ),
                                 
                                   
                                ],
                              ),SizedBox(height: 4,),
                               Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(Icons.chat,size: 18,color: Color(0xfffa9244),),
                                  ),SizedBox(width: 7,),
                                   Padding(
                                     padding: const EdgeInsets.only(right: 16),
                                     child: Text('₹${widget.Astromodel!.data![index].minimumCallDurationCharges!.round()}/ Min',style: TextStyle(height: 1,fontSize: 16,fontWeight: FontWeight.w600,),),
                                   ),
                                   
                                ],
                              ),SizedBox(height: 30,),
                              Container(margin: EdgeInsets.only(left: 20,bottom: 20),height: 45,width: 150,decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],borderRadius: BorderRadius.all(Radius.circular(5)),color: Color(0xfffa9244)),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.phone,color: Colors.white),SizedBox(width: 10,),Padding(
                                     padding: const EdgeInsets.only(right: 10),
                                     child: Text('Talk on Call',style: TextStyle(height: 1,fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                                   ),],),)
                            ],),),
                            
                            ],
                          ),Row(
                            children: [
                              Container(margin: EdgeInsets.only(left: 6,right: 15),width: MediaQuery.of(context).size.width-31,height: 1,color: Color(0xff969696).withOpacity(0.3),),
                            ],
                          )
                        ],
                      ),
                    ),
                     /* title: Text(
                        searchresults![index].placeName.toString(),
                        style: TextStyle(color: Colors.white),
                      ),*/
                      /*onTap: () async{
                       /* setSelectedLocation(
                            searchResults![index].placeId.toString());
                        locations = (await locationFromAddress(searchResults![index].description.toString())).cast<Location>() ;
                        // print('heren  is code $locations');
                        setState(() {

                          _destLatitude = locations![0].latitude;
                          _destLongitude = locations![0].longitude;
                          _lastMapPosition = LatLng(_destLatitude, _destLongitude);
                          // _onAddMarkerButtonPressed();
                        });
                        print(locations);*/
                      },*/
                    );
                  }),
      ):CircularProgressIndicator(),
     /* Stack(children: [Column(children: [
        Row(children: [Padding(padding: EdgeInsets.only(left: 16,bottom: 10),child: Text('Tithi',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xff000000)),),),]),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Tithi Number:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/2,child: Text(widget.Astromodel!.data!.tithi!.details!.tithiNumber.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),SizedBox(height: 2,),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Tithi Name:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.Astromodel!.data!.tithi!.details!.tithiName.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Special:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.Astromodel!.data!.tithi!.details!.special.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),SizedBox(height: 8,),
        Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Summary:',style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.Astromodel!.data!.tithi!.details!.summary.toString(),style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('Deity:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.Astromodel!.data!.tithi!.details!.deity.toString()}',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        Row(children: [
          Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
          Text('End Time:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
          Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.Astromodel!.data!.tithi!.endTime!.hour.toString()}hr ${widget.Astromodel!.data!.tithi!.endTime!.minute.toString()}min ${widget.Astromodel!.data!.tithi!.endTime!.second.toString()}sec',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

        ],),
        SizedBox(height: 20,),
      ],),
        if (searchresults != null &&
            searchresults!.length != 0)
          Row(children:[SizedBox(width: MediaQuery.of(context).size.width/2.8,),Container(
            height: 200.0,width:150, //검색어 리스트도 맵이랑 같은height
           // width: double.infinity, //리스트 아래로 무한대
            decoration: BoxDecoration(
                color: Colors.white,
                //backgroundBlendMode: BlendMode.darken
            ),
          ),]),
        if (searchresults != null &&
            searchresults!.length != 0)
         Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/2.8,),Container(
            height: 200.0,width: 150,
            child: ListView.builder(padding: EdgeInsets.all(0),
                itemCount: searchresults!.length,
                itemBuilder: (contex, index) {
                  return Container(padding: EdgeInsets.only(left: 10),height: 40,width: 150,child: InkWell(onTap: (){setState(() {
                    placeid = searchresults![index].placeId.toString();
                    context.read<AstroCubit>().getAstro({"day":day,"month":monthnumber,"year":year,"placeId":placeid});
                    location.text= searchresults![index].placeName.toString();
                    searchresults!.length = 0;
                    
                  });},
                    child: Text(
                      searchresults![index].placeName.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                   /* title: Text(
                      searchresults![index].placeName.toString(),
                      style: TextStyle(color: Colors.white),
                    ),*/
                    /*onTap: () async{
                     /* setSelectedLocation(
                          searchResults![index].placeId.toString());
                      locations = (await locationFromAddress(searchResults![index].description.toString())).cast<Location>() ;
                      // print('heren  is code $locations');
                      setState(() {

                        _destLatitude = locations![0].latitude;
                        _destLongitude = locations![0].longitude;
                        _lastMapPosition = LatLng(_destLatitude, _destLongitude);
                        // _onAddMarkerButtonPressed();
                      });
                      print(locations);*/
                    },*/
                  );
                }),
          )])


      ],),

      Padding(padding: EdgeInsets.only(left: 16,bottom: 10),child: Text('Nakshatra',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xff000000)),),),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Nakshatra Number:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/2,child: Text('3',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),SizedBox(height: 2,),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Nakshatra Name:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('Kritika',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Ruler:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('Sun',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Deity:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text('${widget.Astromodel!.data!.tithi!.details!.deity.toString()}',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),
      Row(children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Special:',style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.Astromodel!.data!.tithi!.details!.special.toString(),style: TextStyle(height: 1.8,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),SizedBox(height: 8,),
      Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
        Container(margin: EdgeInsets.only(left: 16),width: MediaQuery.of(context).size.width/2.8,child:
        Text('Summary:',style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),),
        Container(width: MediaQuery.of(context).size.width/1.8,child: Text(widget.Astromodel!.data!.tithi!.details!.summary.toString(),style: TextStyle(height: 1.2,fontSize: 14,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),)

      ],),*/



    ],),)),bottomNavigationBar: Container(height: 70,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Container(padding: EdgeInsets.only(left: 26),child:Column(children: [SizedBox(height: 15,),
        Container(height: 22,child:Image.asset('assets/home.png',color: Color(0xff7e7a7e),),),
        Text('Home',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
      ],),),
      Column(children: [SizedBox(height: 15,),
        Container(height: 22,child:Image.asset('assets/talk.png',color: Colors.deepOrangeAccent,),),
        Text('Talk to Astrologer',style: TextStyle(letterSpacing: -.4,height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xfffa9345))),
      ],),
      Column(children: [SizedBox(height: 15,),
        Container(height: 22,child:Image.asset('assets/ask.png'),),
        Text('Ask Question',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
      ],),
      Container(padding: EdgeInsets.only(right: 26),
        child: Column(children: [SizedBox(height: 15,),
          Container(height: 22,child:Image.asset('assets/reports.png'),),
          Text('Reports',style: TextStyle(height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
        ],),
      ),
   /* Column(children: [SizedBox(height: 10,),
        Container(height: 22,child:Icon(Icons.chat),),
        Text('Chat with Astrologer',style: TextStyle(letterSpacing: -0.7,height: 1.8,fontSize: 10,fontWeight: FontWeight.w300,color: Color(0xff7e7a7e))),
      ],)*/
    ],),),);
  }
}*/
