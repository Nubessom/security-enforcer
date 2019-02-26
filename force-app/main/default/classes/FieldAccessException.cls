global abstract with sharing class FieldAccessException extends Exception {
    
    global class NotAccessibleException extends FieldAccessException {
        public NotAccessibleException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    global class NotCreateableException extends FieldAccessException {
        public NotCreateableException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    global class NotUpdateableException extends FieldAccessException {
        public NotUpdateableException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    
    private String objectName;
    private String fieldName;
    
    // Exception class constructor     
    public FieldAccessException(String message, String objectName, String fieldName) {
        // Pass 'message' to the base class
        this.setMessage(message);
        
        this.objectName = objectName;
        this.fieldName = fieldName;
    }
    
    global String getObjectName() {
        return objectName;
    }
    
    global String getFieldName() {
        return fieldName;
    }
}
