1、Masonry使用：
View的属性前面加上mas_前缀，否则可能会造成不可预期的错误，如下所示：
[wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.equalTo(shareWX.mas_bottom);
}];
避免：
[wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.equalTo(shareWX.bottom);
}];

2、API调用
本次重构采用了猿题库的一套东西，详细用法见 https://github.com/yuantiku/YTKNetwork。
建议采用delegate的形式，讲回调统一写在一处，同时可以规避用block带来的一些问题。