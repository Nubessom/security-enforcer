global with sharing class SecurityEnforcer {
    private enum ProcessType {READ, CREATE, EDIT, REMOVE}
    
    global static void validateCanAccess(SObject obj) {
        validateCanAccess(new List<SObject>{obj});    
    }
    
    global static void validateCanCreate(SObject obj) {
        validateCanCreate(new List<SObject>{obj});    
    }
    
    global static void validateCanDelete(SObject obj) {
        validateCanDelete(new List<SObject>{obj});    
    }
    
    global static void validateCanUpdate(SObject obj) {
        validateCanUpdate(new List<SObject>{obj});    
    }
    
    global static void validateCanAccess(List<SObject> objects) {
        validate(objects, ProcessType.READ);
    }
    
    global static void validateCanCreate(List<SObject> objects) {
        validate(objects, ProcessType.CREATE);
    }
    
    global static void validateCanDelete(List<SObject> objects) {
        validate(objects, ProcessType.REMOVE);
    }
    
    global static void validateCanUpdate(List<SObject> objects) {
        validate(objects, ProcessType.EDIT);
    }
    
    private static void validate(List<SObject> objects, ProcessType pType) {
        if(objects == null || objects.size() == 0)
            return;

        //Loop through all objects and get unique types and fields
        Map<Schema.SObjectType, Set<String>> objectToFieldMap = new Map<Schema.SObjectType, Set<String>>();
        for(sObject obj : objects) {
            if(obj == null)
                continue;
            
            Schema.SObjectType objType = obj.getSObjectType();
            if(objectToFieldMap.get(objType) == null)
                objectToFieldMap.put(objType, new Set<String>());
            
            //Add all fields that are populated on this object
            Map<String, Object> populatedFields = obj.getPopulatedFieldsAsMap();
            objectToFieldMap.get(objType)
                			.addAll(populatedFields.keySet());
        }
        
        for(Schema.SObjectType objType : objectToFieldMap.keySet()) {
            sObject obj = objType.newSObject();
            Schema.DescribeSObjectResult objDescribe = obj.getSObjectType().getDescribe();
            
            if(ProcessType.READ.equals(pType) && !objDescribe.isAccessible()) {
                throw new ObjectAccessException.NotAccessibleException('Object API name: '+ objDescribe.getName(), objDescribe.getName());
            }
            else if(ProcessType.CREATE.equals(pType) && !objDescribe.isCreateable()) {
                throw new ObjectAccessException.NotCreateableException('Object API name: ' + objDescribe.getName(), objDescribe.getName());
            }
            else if(ProcessType.REMOVE.equals(pType) && !objDescribe.isDeletable()) {
                throw new ObjectAccessException.NotDeletableException('Object API name: ' + objDescribe.getName(), objDescribe.getName());
            }
            else if(ProcessType.EDIT.equals(pType) && !objDescribe.isUpdateable()) {
                throw new ObjectAccessException.NotUpdateableException('Object API name: ' + objDescribe.getName(), objDescribe.getName());
            }
            
            Map<String, Schema.SObjectField> fields = objDescribe.fields.getMap();
            for(String fieldName: objectToFieldMap.get(objType)) {
                //Skip the field if there is no DescribeFieldResult for it
                if(fields.get(fieldName) == null)
                    continue;
                
                DescribeFieldResult field = fields.get(fieldName).getDescribe();
                
                if(ProcessType.READ.equals(pType) && !field.isAccessible()) {
                    throw new FieldAccessException.NotAccessibleException('Object API name: ' + objDescribe.getName() + ' Field API name: ' + field.getName(), objDescribe.getName(), field.getName());
                }
                else if(ProcessType.CREATE.equals(pType) && !field.isCreateable()) {
                    throw new FieldAccessException.NotCreateableException('Object API name: ' + objDescribe.getName() + ' Field API name: ' + field.getName(), objDescribe.getName(), field.getName());
                }
                else if(ProcessType.EDIT.equals(pType) && !field.isUpdateable() && field.isPermissionable()) {
                    throw new FieldAccessException.NotUpdateableException('Object API name: ' + objDescribe.getName() + ' Field API name: ' + field.getName(), objDescribe.getName(), field.getName());
                }
            }
        }        
    }
}