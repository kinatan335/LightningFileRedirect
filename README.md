# 外部ファイルにリダイレクトする添付ファイルを作成する

画面フローを使用して任意のオブジェクトレコードにSharePointやGoogleDrive等の外部ファイルを開くことができるファイルを作成して、ファイルをダウンロードしたときにリンク先にリダイレクトするようにします。ファイルではなくフォルダやサイトURLでもOK。

## 作るもの

1. 画面フロー
1. コンテンツバージョンを作成するクラス
1. ダウンロードを制御するクラス
1. リダイレクトさせるVisualforceページ
1. Visualforceページのコントローラ

## 使い方

オブジェクトのアクションにソースコードに含まれる画面フロー「コンテンツバージョン: リダイレクト作成」を設定します。

