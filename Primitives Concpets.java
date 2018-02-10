public class CollectionsClass {
    
    //Set Collection
    public set<string> getSetCollection(){
        set<string> setOfStrings = new set<string>{'a','b','c','d','e','f','g','h','i','j'};
            return setOfStrings;
    } 
    
    //List Collection
    public List<string> getListCollection(){
        List<string> ListOfStrings = new List<string>{'apple','ball','cat','dog','elephant','fish','goat','horse','ice cream','joker'};
            return ListOfStrings;
    } 
    
    //List Collection
    public set<string> getMapCollection(){
        map<string,string> mapOfStrings = new map<string,string>();
        mapOfStrings.put('a', 'apple');
        mapOfStrings.put('b', 'ball');
        mapOfStrings.put('c', 'cat'); 
        mapOfStrings.put('d', 'dog');
        mapOfStrings.put('e', 'elephant');
        mapOfStrings.put('f', 'fish');
        mapOfStrings.put('g', 'goat');
        mapOfStrings.put('h', 'horse');
        mapOfStrings.put('i', 'ice Cream');
        mapOfStrings.put('j', 'joker');
        keys.addAll(mapOfStrings.keySet());
        return null;
        
    } 
    
    public set<string> keys {get; set;}
    public List<string> values {get; set;}

    //Modified Version1 
}