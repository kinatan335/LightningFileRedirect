public class ExtFileLinkController {
    
    private String downloadEndpoint;
    public Id cvId {get; set;}
    
    public ExtFileLinkController() {
        cvId = ApexPages.currentPage().getParameters().get('Id');
        ContentVersion conVer = [SELECT Id, ExternalFileUrl__c FROM ContentVersion WHERE Id = :cvId];
        downloadEndpoint = conVer.ExternalFileUrl__c;
    }
    
    public PageReference getPageRef(){
        Pagereference newTabPage = new Pagereference(downloadEndpoint);
        return newTabPage;
    }
     
}