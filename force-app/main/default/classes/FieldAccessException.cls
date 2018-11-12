public abstract class FieldAccessException extends Exception {
    
    public class NotAccessibleException extends FieldAccessException {
        public NotAccessibleException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    public class NotCreateableException extends FieldAccessException {
        public NotCreateableException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    public class NotUpdateableException extends FieldAccessException {
        public NotUpdateableException(String message, String objectName, String fieldName) {
            super(message, objectName, fieldName);
        }
    }
    
    public String objectName;
    public String fieldName;
    
    // Exception class constructor     
    public FieldAccessException(String message, String objectName, String fieldName) {
        // Pass 'message' to the base class
        this.setMessage(message);
        
        this.objectName = objectName;
        this.fieldName = fieldName;
    }
    
    public String getObjectName() {
        return objectName;
    }
    
    public String getFieldName() {
        return fieldName;
    }
}