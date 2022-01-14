part of '../../mp_flutter_runtime.dart';

class _ClipRRect extends ComponentView {
  _ClipRRect({
    Key? key,
    Map? data,
    Map? parentData,
    required _MPComponentFactory componentFactory,
  }) : super(
            key: key,
            data: data,
            parentData: parentData,
            componentFactory: componentFactory);

  @override
  Widget builder(BuildContext context) {
    return ClipRRect(
      borderRadius: getBorderRadiusFromAttributes(context, 'borderRadius') ??
          BorderRadius.circular(0),
      child: getWidgetFromChildren(context),
    );
  }
}
