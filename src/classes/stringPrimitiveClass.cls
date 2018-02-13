/********
* Class Name: stringPrimitiveClass
* CreateBy: Sai - 26 Jan,2017
* Description: Practicing Primitivies and Methods
* --------------------------------------------------------
* History
* --------------------------------------------------------
* Last ModifiedBy:
* Comments: 
* ******
*/

public class stringPrimitiveClass {
    
    public string integerValueIs{get; set;}
    public string StringValueIs{get; set;}
    public string isBoolean{get; set;}    
    public string TodayDateIs{get; set;}
    public string TodayDateTimeIs{get; set;}
    public string DoubleValueIs{get; set;}
    
    
    //constructor
    public stringPrimitiveClass(){
        // getCallSingleStringVar();
    }
    
    public String getCallSingleStringVar() {
    
        StringValueIs = 'Akash';
    
        system.debug('********Student Name is: '+StringValueIs);
    
        return StringValueIs ;
    }  
    
    public integer getCallSingleIntegerVar(){
    
        integer integerValueIs = 12345678;
    
        system.debug('********Roll Number Is: '+integerValueIs);
    
        return integerValueIs;
    }
    
    public boolean getCallBooleanVar(){
        boolean isBoolean = True;
        system.debug('******** Is Boolean? : '+isBoolean);
        return isBoolean;
    }
    
    public date getCallDateVar(){
        date TodayDateIs = date.today();
        system.debug('********Today Date is : '+TodayDateIs);
        return TodayDateIs;
    }
    
    public datetime getCallDateTimeVar(){
        datetime TodayDateTimeIs = Datetime.now();
        system.debug('********Today Datetime is : '+TodayDateTimeIs);
        return TodayDateTimeIs;
    }
    
    public double getCallDoubleVar(){
        double DoubleValueIs = 12345.3456789;
        system.debug('********Double value is : '+DoubleValueIs);
        return DoubleValueIs;
    }
    

}