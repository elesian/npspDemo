public with sharing class AllObjectsAllFields {


    //Retrieve all fields for all objects
    public static void dataDictionary(List<String> objs, String fileName) {

    //GLOBAL - get a list of all objects
    Map<String, Schema.SObjectType> gd = 
    Schema.getGlobalDescribe();

    List<String> objectList = new List<String>();

    //get list of strings and filter keyset depending on if Objs has 1 or more elements

    if(objs.size()==0){

        
        objectList = new List<String>(gd.keySet());}

    else{
        
        objectList = new List<String>(objs.Clone());
    }

    //container for dictionary
    Map<String, List<String>> dictionary = new Map<String, List<String>>();

    //Hold String Header
    String csvColumnHeader = 'Object, FieldLabel, API Field Name, Relationship Name, Data Type\n';
    List<String> csvRowValues = new List<String>();
    

    //loop through each object - global
    For(String currentObject : objectList){


        //add API values to objectFields
        for(Schema.SObjectField field :gd.get(currentObject).getDescribe().fields.getMap().Values()) {

            String currentField = field.getDescribe().getName();
            String fieldLabel = field.getDescribe().getLabel();
            String relationshipName = field.getDescribe().getRelationshipName();
            String dataType = field.getDescribe().getType().name();
            
            String csvRowVal = currentObject + ',' + fieldLabel + ',' + currentField + ',' + RelationshipName + ',' + dataType;
            csvRowValues.add(csvRowVal);
            
        }
        
    } 

    String csvFile = csvColumnHeader + String.join(csvRowValues, '\n');

    ContentVersion file = new ContentVersion(
        title = fileName,
        versionData = Blob.valueOf(csvFile),
        pathOnClient = '/' + fileName + '.csv');

        insert file;

}


}
