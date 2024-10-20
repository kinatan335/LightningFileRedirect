# 外部ファイルにリダイレクトする添付ファイルを作成する

画面フローを使用して任意のオブジェクトレコードにSharePointやGoogleDrive等の外部ファイルを開くことができるファイルを作成して、ファイルをダウンロードしたときにリンク先にリダイレクトするようにします。ファイルではなくフォルダやサイトURLでもOK。

## 含まれているもの
1. 共有リンクURLを保持するカスタム項目 ExternalFileUrl__c
1. 画面フローで使用するトースト表示Auraコンポートネント showToast
1. 共有リンク名やリンクURLを入力する画面フロー ContentVersion_createRedirect

## 使い方

ソースコードに含まれる画面フロー「コンテンツバージョン: リダイレクト作成」をオブジェクトのアクションに設定してレイアウトに追加する。Lightningページに配置する場合は画面フローにタイトルテキストを追加すると良い。

### ロック解除済パッケージのインストール

ノーコードで使用する場合は、以下URLからインストールする。
https\://{MyDomainName}.lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tIU000000fEBwYAM
