global abstract with sharing class ObjectAccessException extends Exception {
    
    global class NotAccessibleException extends ObjectAccessException {
        public NotAccessibleException(String message, String objectName) {
            super(message, objectName);
        }
    }
    global class NotCreateableException extends ObjectAccessException {
        public NotCreateableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    global class NotUpdateableException extends ObjectAccessException {
        public NotUpdateableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    global class NotDeletableException extends ObjectAccessException {
        public NotDeletableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    
    private String objectName;
    
    // Exception class constructor     
    public ObjectAccessException(String message, String objectName) {
        // Pass 'message' to the base class
        this.setMessage(message);
        
        this.objectName = objectName;
    }
    
    global String getObjectName() {
        return objectName;
    }
}
