import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterpoke/models.dart';
import 'package:flutterpoke/pages/detail.dart';
import 'package:flutterpoke/utils/db.dart';
import 'package:flutterpoke/utils/extensions.dart';
import 'package:flutterpoke/utils/requesters.dart';
import 'package:flutterpoke/utils/routes.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutterpoke/views/faveView.dart';
import 'package:flutterpoke/views/headerView.dart';
import 'package:flutterpoke/views/linkedText.dart';
import 'package:flutterpoke/views/progressBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';

class FavesPage extends StatefulWidget {
  FavesPage({Key key}) : super(key: key);

  @override
  _FavesPageState createState() => _FavesPageState();
}

class _FavesPageState extends State<FavesPage> {
  FetchStatus status;
  List<FavePoke> faves;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchFaves();
    });
  }

  void _fetchPokemon(String name) {
    setState(() {
      status = FetchStatus.loading;
    });

    fetchPokemon(name).then((pokemon) {
      setState(() {
        status = FetchStatus.success;
      });
      Navigator.push(context,
          FadeRoute(exitPage: widget, enterPage: DetailPage(poke: pokemon)));
    }).catchError((error) {
      debugPrint(error.toString());
      setState(() {
        Fluttertoast.showToast(msg: "Pokemon not found. Try again.");
        status = FetchStatus.failed;
      });
    });
  }

  _fetchFaves() async {
    List<FavePoke> currentFaves = await getFaves();
    setState(() {
      faves = currentFaves;
    });
  }

  _delete(int id) async {
    removeFave(id);
    _fetchFaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(capitalize("Favorites"),
                style: AppStyles.whiteTitleStyle)),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              children: <Widget>[
                for (FavePoke poke in faves)
                  Slidable(
                    actionExtentRatio: 0.2,
                    actionPane: SlidableDrawerActionPane(),
                    child: FaveView(
                      poke: poke,
                      onPressed: () => _fetchPokemon(poke.name),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        color: AppColors.dark,
                        icon: Icons.delete,
                        caption: "Delete",
                        onTap: () => _delete(poke.id),
                      )
                    ],
                  )
              ],
            )),
            if (status == FetchStatus.loading)
              SizedBox.expand(
                  child: AnimatedOpacity(
                      opacity: status == FetchStatus.loading ? 1 : 0,
                      duration: AppDurations.fadeDuration,
                      child: Container(
                          color: AppColors.whiteTransparent,
                          child: Stack(
                            children: <Widget>[Center(child: ProgressBar())],
                          ))
                      // Expanded(...)
                      ))
          ],
        ));
  }
}
