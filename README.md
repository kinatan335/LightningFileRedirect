# 外部ファイルにリダイレクトする添付ファイルを作成する

画面フローを使用して任意のオブジェクトレコードにSharePointやGoogleDrive等の外部ファイルを開くことができるファイルを作成して、ファイルをダウンロードしたときにリンク先にリダイレクトするようにします。ファイルではなくフォルダやサイトURLでもOK。

## 含まれているもの
1. 共有リンクURLを保持するカスタム項目 ExternalFileUrl__c
1. 画面フローで使用するトースト表示Auraコンポートネント showToast
1. 共有リンク名やリンクURLを入力する画面フロー ContentVersion_createRedirect
1. コンテンツバージョンを作成するクラス ExtFileLinkCreateByFlow
1. ダウンロードを制御するクラス ContentDownloadHandlerFactoryImpl
1. リダイレクトさせるVisualforceページ ExtFileLinkControl
1. Visualforceページのコントローラ ExtFileLinkController

## 使い方

ソースコードに含まれる画面フロー「コンテンツバージョン: リダイレクト作成」をLightningページに配置、またはオブジェクトのアクションに設定してレイアウトに追加します。

### ロック解除済パッケージのインストール

ノーコードで使用する場合は、以下URLからインストールを行う。{PackageVersionId}はリリースに記載。
https\://{MyDomainName}.lightning.force.com/packagingSetupUI/ipLanding.app?apvId={PackageVersionId}