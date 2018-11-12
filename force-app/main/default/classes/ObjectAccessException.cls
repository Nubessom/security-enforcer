public abstract class ObjectAccessException extends Exception {
    
    public class NotAccessibleException extends ObjectAccessException {
        public NotAccessibleException(String message, String objectName) {
            super(message, objectName);
        }
    }
    public class NotCreateableException extends ObjectAccessException {
        public NotCreateableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    public class NotUpdateableException extends ObjectAccessException {
        public NotUpdateableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    public class NotDeletableException extends ObjectAccessException {
        public NotDeletableException(String message, String objectName) {
            super(message, objectName);
        }
    }
    
    public String objectName;
    
    // Exception class constructor     
    public ObjectAccessException(String message, String objectName) {
        // Pass 'message' to the base class
        this.setMessage(message);
        
        this.objectName = objectName;
    }
    
    public String getObjectName() {
        return objectName;
    }
}