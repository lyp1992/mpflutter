part of './mp_flutter_runtime.dart';

class MPPage extends StatefulWidget {
  final MPEngine engine;
  final String? initialRoute;
  final Map? initialParams;

  const MPPage({
    Key? key,
    required this.engine,
    this.initialRoute,
    this.initialParams,
  }) : super(key: key);

  @override
  State<MPPage> createState() => _MPPageState();
}

class _MPPageState extends State<MPPage> with MPDataReceiver, RouteAware {
  bool firstSetted = false;
  ModalRoute? route;
  int? viewId;
  Map? scaffoldData;

  @override
  void dispose() {
    super.dispose();
    if (route != null && !route!.isActive && viewId != null) {
      widget.engine._router._disposeRoute(viewId!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!firstSetted) {
      firstSetted = true;
      route = ModalRoute.of(context);
      widget.engine._router
          .requestRoute(viewport: MediaQuery.of(context).size)
          .then((viewId) {
        this.viewId = viewId;
        widget.engine._addManageView(viewId, this);
      });
    }
  }

  @override
  NavigatorState? getNavigator() {
    return Navigator.of(context);
  }

  @override
  void didReceivedFrameData(Map message) {
    setState(() {
      scaffoldData = message['scaffold'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (scaffoldData != null) {
      return widget.engine._componentFactory.create(scaffoldData);
    }
    return Container();
  }
}
