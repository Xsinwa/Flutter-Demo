import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:provide/provide.dart';

///* 全局数据共享
class Store {

  static init({model, child, dispose = true}) {
    final providers = Providers()..provide(Provider.value(SharedValuesModel()));
    return ProviderNode(
      child: child,
      providers: providers,
      dispose: dispose,
    );
  }

  static connect<T>({builder, child, scope}){
    return Provide<T>(
      builder: builder,
      child: child,
      scope: scope,
    );
  }

  static T value<T>(context, {scope}){
    return Provide.value(context, scope: scope);
  }
}
