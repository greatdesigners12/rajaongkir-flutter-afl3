part of "../views.dart";



Future<void> startLoading(context) async {
  return await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const SimpleDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent, // can change this to your prefered color
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    },
  );
}

Future<void> stopLoading(context) async {
    Navigator.of(context).pop();
  }
