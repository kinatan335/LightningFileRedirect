public class ContentDownloadHandlerFactoryImpl implements Sfc.ContentDownloadHandlerFactory {

    public Sfc.ContentDownloadHandler getContentDownloadHandler(List<ID> ids, Sfc.ContentDownloadContext context) {
        Sfc.ContentDownloadHandler contentDownloadHandler = new Sfc.ContentDownloadHandler();
        
        // ダウンロードが実行されたコンテンツバージョンを取得
        List<ContentVersion> conVerList = [
            SELECT Id, ExternalFileUrl__c 
            FROM ContentVersion
            WHERE Id IN :ids
        ];
        
        // パッケージの名前空間を取得
        String namespacePrefix;
        String[] classNameParts = String.valueOf(ContentDownloadHandlerFactoryImpl.class).split('\\.', 2);
        if(classNameParts.size() > 1) {
            Type classType = Type.forName(classNameParts[0], classNameParts[1]);
            if(classType == ContentDownloadHandlerFactoryImpl.class) {
                namespacePrefix = classNameParts[0] + '__';
            } else {
                namespacePrefix = '';
            }
        } else {
            // ドット区切りが無い場合は名前空間無し
            namespacePrefix = '';
        }

        // ダウンロード制御
        if (conVerList.size() == 1 && conVerList[0].ExternalFileUrl__c != null ) {
            // リダイレクト処理
            contentDownloadHandler.isDownloadAllowed = false;
            contentDownloadHandler.downloadErrorMessage = 'リンク先のファイルを開きます';
            contentDownloadHandler.redirectUrl ='/apex/'+namespacePrefix+'ExtFileLinkControl?Id='+conVerList[0].Id;
        } else {
            // 通常処理
            contentDownloadHandler.isDownloadAllowed = true;
        }

        return contentDownloadHandler;
    }

}
