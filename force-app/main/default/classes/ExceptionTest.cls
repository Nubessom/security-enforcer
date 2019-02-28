@isTest
public with sharing class ExceptionTest {
    @isTest
    public static void ObjectAccessExceptionAccessibleTest(){
        try
        {
            throw new ObjectAccessException.NotAccessibleException('this is my message', 'objectName');
        }
        catch(ObjectAccessException.NotAccessibleException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
        }
    }
    
    @isTest
    public static void ObjectAccessExceptionCreateableTest(){
        try
        {
            throw new ObjectAccessException.NotCreateableException('this is my message', 'objectName');
        }
        catch(ObjectAccessException.NotCreateableException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
        }
    }
    
    @isTest
    public static void ObjectAccessExceptionUpdateableTest(){
        try
        {
            throw new ObjectAccessException.NotUpdateableException('this is my message', 'objectName');
        }
        catch(ObjectAccessException.NotUpdateableException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
        }
    }
    
    @isTest
    public static void ObjectAccessExceptionDeletableTest(){
        try
        {
            throw new ObjectAccessException.NotDeletableException('this is my message', 'objectName');
        }
        catch(ObjectAccessException.NotDeletableException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
        }
    }
    
    @isTest
    public static void FieldAccessExceptionAccessibleTest(){
        try
        {
            throw new FieldAccessException.NotAccessibleException('this is my message', 'objectName', 'fieldName');
        }
        catch(FieldAccessException.NotAccessibleException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
            system.assertEquals('fieldName', ex.getFieldName());
        }
    }
    
    @isTest
    public static void FieldAccessExceptionCreateableTest(){
        try
        {
            throw new FieldAccessException.NotCreateableException('this is my message', 'objectName', 'fieldName');
        }
        catch(FieldAccessException.NotCreateableException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
            system.assertEquals('fieldName', ex.getFieldName());
        }
    }
    
    @isTest
    public static void FieldAccessExceptionUpdateableTest(){
        try
        {
            throw new FieldAccessException.NotUpdateableException('this is my message', 'objectName', 'fieldName');
        }
        catch(FieldAccessException.NotUpdateableException ex)
        {
            system.assertEquals('this is my message', ex.getMessage());
            system.assertEquals('objectName', ex.getObjectName());
            system.assertEquals('fieldName', ex.getFieldName());
        }
    }
}
