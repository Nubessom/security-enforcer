# SecurityEnforcer library
Library for enforcing FLS and CRUD rules in Apex effortlessly

## Dev, Build and Test
To use the library clone the repo and use sources from force-app/main/classes

## Features
Supports Create, Read, Delete and Update DML operations.
Works on a single object aswell as on an array of objects of the same type.
It presumes that objects in an array are of the same type.

## Code Samples
Object access validation sample: 
```
SecurityEnforcer.validateCanAccess(sObject or sObject list);
```
Which throws the following exceptions:
```
ObjectAccessException.NotAccessibleException() - for object
FieldAccessException.NotAccessibleException() - for field
```
Object create validation sample: 
``` 
SecurityEnforcer.validateCanCreate(object or object list);
```
Which throws the following exceptions:
```
ObjectAccessException.NotCreatableException() - for object
FieldAccessException.NotCreatableException() - for field
```
Object delete validation sample: 
```
SecurityEnforcer.validateCanDelete(object or object list);
```
Which throws the following exceptions:
```
ObjectAccessException.NotDeleteableException() - for object
```
Object update validation sample: 
```
SecurityEnforcer.validateCanUpdate(object or object list);
```
Which throws the following exceptions:
```
ObjectAccessException.NotUpdateableException() - for object
FieldAccessException.NotUpdateableException() - for field
```
Object name access on exception:
```
ObjectAccessException.getObjectName(); - for object exception
FieldAccessException.getObjectName(); - for field exception
```
Field name access on exception:
FieldAccessException.getFieldName(); - for field exception

## Todo
upsert support

2018 | Nubessom