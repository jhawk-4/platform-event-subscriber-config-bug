@isTest
public with sharing class myEventHandlerTest {
    
    @isTest
    static void createTestEvent() {

        Test.startTest();

        Database.SaveResult sr = Eventbus.publish(new My_Event__e());

        Test.stopTest();

        System.assert(sr.isSuccess());

    }
}
