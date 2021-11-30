trigger myEventHandler on My_Event__e (after insert) {
    System.debug(System.LoggingLevel.INFO, 'The running user is: ' + UserInfo.getUserName());
}