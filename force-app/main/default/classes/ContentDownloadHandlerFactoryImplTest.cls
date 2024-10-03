@IsTest
public class ContentDownloadHandlerFactoryImplTest {
    
    @IsTest
    static void testSingleContentVersionWithExternalUrl() {
        // Create mock context
        // Sfc.ContentDownloadContext mockContext = new Sfc.ContentDownloadContext();
        
        // Create a test ContentVersion with ExternalFileUrl__c populated
        ContentVersion cv = new ContentVersion(
            Title = 'Test Content',
            PathOnClient = 'Test Content.pdf',
            ExternalFileUrl__c = 'https://example.com/file.pdf',
            VersionData = Blob.valueOf('Invisible File')
        );
        insert cv;
        
        // Test the factory
        List<Id> contentVersionIds = new List<Id>{cv.Id};
        ContentDownloadHandlerFactoryImpl factory = new ContentDownloadHandlerFactoryImpl();
        // Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, mockContext);
        Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, null);
        
        // Assertions
        System.assertEquals(false, handler.isDownloadAllowed, 'Download should not be allowed for external URL.');
        System.assertEquals('リンク先のファイルを開きます', handler.downloadErrorMessage, 'Error message should indicate external link.');
        System.assert(handler.redirectUrl.contains(cv.Id), 'Redirect URL should contain the ContentVersion ID.');
    }

    @IsTest
    static void testMultipleContentVersionsOrNullExternalUrl() {
        // Create mock context
        // Sfc.ContentDownloadContext mockContext = new Sfc.ContentDownloadContext();
        
        // Create a test ContentVersion with ExternalFileUrl__c as null
        ContentVersion cv1 = new ContentVersion(
            Title = 'Test Content 1',
            PathOnClient = 'Test Content.pdf',
            ExternalFileUrl__c = null,
            VersionData = Blob.valueOf('Invisible File')
        );
        insert cv1;
        
        // Another test ContentVersion
        ContentVersion cv2 = new ContentVersion(
            Title = 'Test Content 2',
            PathOnClient = 'Test Content.pdf',
            ExternalFileUrl__c = null,
            VersionData = Blob.valueOf('Invisible File')
        );
        insert cv2;
        
        // Test case with multiple IDs
        List<Id> contentVersionIds = new List<Id>{cv1.Id, cv2.Id};
        ContentDownloadHandlerFactoryImpl factory = new ContentDownloadHandlerFactoryImpl();
        // Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, mockContext);
        Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, null);
        
        // Assertions
        System.assertEquals(true, handler.isDownloadAllowed, 'Download should be allowed for multiple records or null ExternalFileUrl.');
        System.assertEquals(null, handler.downloadErrorMessage, 'There should be no error message for multiple records.');
        System.assertEquals(null, handler.redirectUrl, 'There should be no redirect URL.');
    }
    
    @IsTest
    static void testSingleContentVersionWithNullExternalUrl() {
        // Create mock context
        // Sfc.ContentDownloadContext mockContext = new Sfc.ContentDownloadContext();
        
        // Create a single test ContentVersion with ExternalFileUrl__c as null
        ContentVersion cv = new ContentVersion(
            Title = 'Test Content',
            PathOnClient = 'Test Content.pdf',
            ExternalFileUrl__c = null,
            VersionData = Blob.valueOf('Invisible File')
        );
        insert cv;
        
        // Test the factory
        List<Id> contentVersionIds = new List<Id>{cv.Id};
        ContentDownloadHandlerFactoryImpl factory = new ContentDownloadHandlerFactoryImpl();
        // Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, mockContext);
        Sfc.ContentDownloadHandler handler = factory.getContentDownloadHandler(contentVersionIds, null);
        
        // Assertions
        System.assertEquals(true, handler.isDownloadAllowed, 'Download should be allowed for single record with null ExternalFileUrl.');
        System.assertEquals(null, handler.downloadErrorMessage, 'There should be no error message for null ExternalFileUrl.');
        System.assertEquals(null, handler.redirectUrl, 'There should be no redirect URL.');
    }
}
