@isTest
public class ExtFileLinkControllerTest {
    
    @testSetup
    static void setupTestData() {
        // Create a ContentVersion record with the required fields
        ContentVersion cv = new ContentVersion(
            Title = 'Test Content Version',
            PathOnClient = 'Test.pdf',
            VersionData = Blob.valueOf('Test Data'),
            ExternalFileUrl__c = 'https://example.com/testfile'
        );
        insert cv;
    }
    
    @isTest
    static void testConstructorAndPageRef() {
        // Retrieve the ContentVersion created in the @testSetup
        ContentVersion cv = [SELECT Id FROM ContentVersion LIMIT 1];
        
        // Mock the page parameters by setting the cvId in the URL parameters
        Test.startTest();
        ApexPages.currentPage().getParameters().put('Id', cv.Id);
        
        // Instantiate the controller
        ExtFileLinkController controller = new ExtFileLinkController();
        
        // Assert that the cvId is set correctly from the page parameters
        System.assertEquals(cv.Id, controller.cvId, 'cvId should be set to the page parameter Id.');
        
        // Assert that the downloadEndpoint was set correctly from the ContentVersion.ExternalFileUrl__c
        System.assertEquals('https://example.com/testfile', controller.getPageRef().getUrl(), 'The URL should be set to the ExternalFileUrl__c.');
        
        Test.stopTest();
    }
    
}
