global with sharing class SecurityEnforcer {
    private enum ProcessType {READ, CREATE, EDIT, REMOVE}
    
    global static void validateCanAccess(SObject obj) {
        validateCanAccess(new List<SObject>{obj});    
    }
    
    global static void validateCanCreate(SObject obj) {
        validateCanCreate(new List<SObject>{obj});    
    }

    global static void validateCanDelete(Id objId) {
        validateCanDelete(new List<Id>{objId});    
    }

    global static void validateCanDelete(Set<Id> objIdSet) {
        validateCanDelete(new List<Id>(objIdSet));    
    }

    global static void validateCanDelete(List<Id> objIdList) {
        List<SObject> objList = new List<SObject>();
        for(Id objId : objIdList) {
            objList.add(objId.getSObjectType().newSObject());
        }
        validateCanDelete(objList);    
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
    
    global static List<SObject> updateSObject(SObject obj) {
        return updateSObject(new List<SObject>{obj});
    }
    
    global static List<SObject> updateSObject(List<SObject> obj) {
        validateCanUpdate(obj);
        update obj;
        return obj;
    }
    
    global static List<SObject> createSObject(SObject obj) {
        return createSObject(new List<SObject>{obj});
    }
    
    global static List<SObject> createSObject(List<SObject> obj) {
        validateCanCreate(obj);
        insert obj;
        return obj;
    }
    
    global static void deleteSObject(SObject obj) {
        validateCanDelete(obj);
        delete obj;
    }
    
    global static void deleteSObject(List<SObject> obj) {
        validateCanDelete(obj);
        delete obj;
    }
    
    private static void validate(List<SObject> objects, ProcessType pType) {
        if(objects == null || objects.size() == 0)
            return;

        //Loop through all objects and get unique types and fields
        Map<Schema.SObjectType, Set<String>> objectToFieldMap = new Map<Schema.SObjectType, Set<String>>();
        for(SObject obj : objects) {
            processSObjectTypeAndFields(objectToFieldMap, obj);
        }
        
        for(Schema.SObjectType objType : objectToFieldMap.keySet()) {
            SObject obj = objType.newSObject();
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
                System.debug('[SE] : ' + fieldName);
                System.debug('[SE] : ' + fields.get(fieldName));
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

    private static void processSObjectTypeAndFields(Map<Schema.SObjectType, Set<String>> objectToFieldMap, SObject obj) {
        if(obj == null)
            return;
        
        Schema.SObjectType objType = obj.getSObjectType();
        if(objectToFieldMap.get(objType) == null)
            objectToFieldMap.put(objType, new Set<String>());
        
        //Get all fields that are populated on this object
        Map<String, Object> populatedFields = obj.getPopulatedFieldsAsMap();

        for(String fieldName : populatedFields.keySet()) {
            //Check if field is actually a relationship
            if(fieldName.endsWith('__r')) {
                List<SObject> relatedObjects = new List<SObject>();

                try {
                    //Try to interpret Relationship as Parent first
                    relatedObjects.add(obj.getSObject(fieldName));
                }
                catch(SObjectException ex) {
                    //It is not Parent relationship, so probably child
                    relatedObjects = obj.getSObjects(fieldName);
                }

                //Process all relationship objects
                for(SObject relObj : relatedObjects) {
                    processSObjectTypeAndFields(objectToFieldMap, relObj);
                }
            }
            else {
                //Process standard object field
                objectToFieldMap.get(objType).add(fieldName);
            }
        }
    }
}