public class ContentDownloadHandlerFactoryImpl implements Sfc.ContentDownloadHandlerFactory {

    public Sfc.ContentDownloadHandler getContentDownloadHandler(List<ID> ids, Sfc.ContentDownloadContext context) {
        Sfc.ContentDownloadHandler contentDownloadHandler = new Sfc.ContentDownloadHandler();

        List<ContentVersion> conVerList = [
            SELECT Id, ExternalFileUrl__c 
            FROM ContentVersion
            WHERE Id IN :ids
        ];

        if (conVerList.size() == 1 && conVerList[0].ExternalFileUrl__c != null ) {
            // リダイレクト処理
            contentDownloadHandler.isDownloadAllowed = false;
            contentDownloadHandler.downloadErrorMessage = 'リンク先のファイルを開きます';
            contentDownloadHandler.redirectUrl ='/apex/ExtFileLinkControl?Id='+conVerList[0].Id;
        } else {
            // 通常処理
            contentDownloadHandler.isDownloadAllowed = true;
        }

        return contentDownloadHandler;
    }

}
