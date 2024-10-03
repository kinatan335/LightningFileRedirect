@IsTest
public class ExtFileLinkCreateByFlowTest {

    @TestSetup
    static void setupTestData() {
        // Create a test Account or any relevant sObject for LinkedEntityId
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create a test ContentVersion for Overwrite testing
        ContentVersion contentVer = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'Test File.lnk',
            VersionData = Blob.valueOf('Test file data'),  // Simulate file content
            FirstPublishLocationId = testAccount.Id
        );
        insert contentVer;
        
    }

    @IsTest
    static void testCreateExtFileLinkConVerOverwriteTrue() {
        // Prepare the test data
        List<ExtFileLinkCreateByFlow.Request> requests = new List<ExtFileLinkCreateByFlow.Request>();
        ExtFileLinkCreateByFlow.Request request = new ExtFileLinkCreateByFlow.Request();
        request.reqRecordId = [SELECT Id FROM Account LIMIT 1].Id;
        request.reqFileName = 'Test File';
        request.reqIsOverwrite = true;  // Case where overwrite is true
        request.reqExtFileUrl = 'https://example.com/testfile';
        request.reqFileDesc = 'Test file description';
        requests.add(request);

        // Execute the method
        Test.startTest();
        List<ExtFileLinkCreateByFlow.Result> results = ExtFileLinkCreateByFlow.createExtFileLinkConVer(requests);
        Test.stopTest();

        // Assert that the results are not null
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(1, results.size(), 'There should be one result returned');
        System.assertNotEquals(null, results[0].resConDocId, 'ContentDocument ID should be returned');
    }

    @IsTest
    static void testCreateExtFileLinkConVerOverwriteFalse() {
        // Prepare the test data
        List<ExtFileLinkCreateByFlow.Request> requests = new List<ExtFileLinkCreateByFlow.Request>();
        ExtFileLinkCreateByFlow.Request request = new ExtFileLinkCreateByFlow.Request();
        request.reqRecordId = [SELECT Id FROM Account LIMIT 1].Id;
        request.reqFileName = 'New Test File';
        request.reqIsOverwrite = false;  // Case where overwrite is false
        request.reqExtFileUrl = 'https://example.com/newfile';
        request.reqFileDesc = 'New file description';
        requests.add(request);

        // Execute the method
        Test.startTest();
        List<ExtFileLinkCreateByFlow.Result> results = ExtFileLinkCreateByFlow.createExtFileLinkConVer(requests);
        Test.stopTest();

        // Assert that the results are not null
        System.assertNotEquals(null, results, 'Results should not be null');
        System.assertEquals(1, results.size(), 'There should be one result returned');
        System.assertNotEquals(null, results[0].resConDocId, 'ContentDocument ID should be returned');
    }

}
