# search-platform-dependent-characters package

Search dependent characters for Japanese text.

---

日本語環境下で、エディタの選択範囲内に機種依存文字が混入していないか検査します。

##使用方法
エディタ上で検索したい範囲を選択状態にし、「Menu＞Packages」や「右クリックMenu」から「Search Platform Dependent Characters」を実行

###Defaultのキーバインド
shift-alt-j

###機種依存文字が含まれていない場合
アラートで以下が表示されます

```
[O] No exist platform-dependent-characters.
```

###機種依存文字が含まれている場合

```
[X] Exist platform-dependent-characters.

Relative Line(in current selection): 9

Nearby:
あいうえお
かきく
```

Relative Line：選択範囲の先頭を1とした行数
Nearby：機種依存文字の直前の文字列を数十文字分だけ表示
