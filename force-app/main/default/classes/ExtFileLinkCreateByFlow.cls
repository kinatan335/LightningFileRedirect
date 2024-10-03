public with sharing class ExtFileLinkCreateByFlow {

    public class Request {
        @InvocableVariable(label='レコードID' required=true)
        public Id reqRecordId;
        @InvocableVariable(label='ファイル名' required=true)
        public String reqFileName;
        @InvocableVariable(label='同じファイル名の場合上書きする(true/false)' description='true:新規バージョンが作成されます' required=true )
        public Boolean reqIsOverwrite;
        @InvocableVariable(label='外部ファイルURL' required=true)
        public String reqExtFileUrl;
        @InvocableVariable(label='ファイルの説明' required=false)
        public String reqFileDesc;
    }

    public class Result{
        @InvocableVariable(Label='コンテンツドキュメントID')
        public String resConDocId;
        @InvocableVariable(Label='エラーメッセージ' description='処理中に発生したエラー')
        public String errorMessage;
    }

    @InvocableMethod(Label='外部ファイルリンク作成')
    public static List<Result> createExtFileLinkConVer(List<Request> requests) {
        
        List<Result> results = new List<Result>();

        Request req = requests.get(0);
        Result result = new Result();
        result.errorMessage = '';

        try {
            Id existingConDocId = null;

            // 上書きONの場合、既存のContentDocumentを確認・取得
            if (req.reqIsOverwrite) {
                List<ContentDocumentLink> conDocLinkList = [
                    SELECT ContentDocumentId 
                    FROM ContentDocumentLink 
                    WHERE LinkedEntityId = :req.reqRecordId
                ];

                if (!conDocLinkList.isEmpty()) {
                    Set<Id> contentDocumentIds = new Set<Id>();
                    for (ContentDocumentLink conDocLink : conDocLinkList) {
                        contentDocumentIds.add(conDocLink.ContentDocumentId);
                    }

                    List<ContentDocument> conDocList = [
                        SELECT Id 
                        FROM ContentDocument 
                        WHERE Id IN :contentDocumentIds AND Title = :req.reqFileName
                        ORDER BY LastmodifiedDate DESC
                    ];

                    if (!conDocList.isEmpty()) {
                        existingConDocId = conDocList.get(0).Id;
                    }
                }
            }

            // ContentVersionを作成
            ContentVersion conVer = new ContentVersion();
            conVer.Title = req.reqFileName;
            conVer.PathOnClient = req.reqFileName + '.lnk';
            conVer.ExternalFileUrl__c = req.reqExtFileUrl;
            conVer.Description = req.reqFileDesc;
            conVer.OwnerId = UserInfo.getUserId();
            conVer.VersionData = Blob.valueOf('Invisible file');

            if (existingConDocId == null) {
                // ContentDocumentは自動作成される
                conVer.FirstPublishLocationId = req.reqRecordId;
            } else {
                conVer.ContentDocumentId = existingConDocId;
            }

            insert as user conVer;

            // 作成されたContentVersionのContentDocumentを取得
            ContentDocument conDoc = [
                SELECT Id
                FROM ContentDocument
                WHERE LatestPublishedVersionId = :conVer.Id
            ];
            result.resConDocId = conDoc.Id;

        } catch (Exception e) {
            result.errorMessage = 'Error: ' + e.getMessage();
        }

        results.add(result);
        return results;

    }
}
