# RAC-MVVMTest
ReactiveCocoa的基本使用及基于MVVM+ReactiveCocoa的应用

关于ReactiveCocoa

ReactiveCocoa结合了一些编程模式：

函数式编程：利用高阶函数，即将函数作为其它函数的参数。
响应式编程：关注于数据流及变化的传播。
基于以上两点，ReactiveCocoa被当成是函数响应编程(Functional Reactive Programming, FRP)框架。
https://github.com/ReactiveCocoa/ReactiveCocoa

注：在使用cocopods导入ReactiveCocoa时：
use_frameworks!
pod 'ReactiveCocoa','~> 4.0.4-alpha-1' 即可

关于MVVM

在MVVM中View和ViewController正式联系在一起。View仍然不能直接引用模型Model，当然Controller也不能。
相反他们引用视图模型ViewModel。
ViewModel是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他各种各样代码的好地方。
ViewModel不要引用UIKit。
展示逻辑放在了ViewModel中，比如Model的值映射到一个格式化字符串。

关于MVVM+RAC的结合
ReactiveCocoa所扮演的角色:进行ViewModel连接"粘合"工作.
