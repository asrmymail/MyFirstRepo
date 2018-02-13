public with sharing class jeffDouglasDynamicSearch {

  // the soql without the order and limit
  private String soql {get;set;}
  // the collection of contacts to display
  public List<Contact> contacts {get;set;}

  // the current sort direction. defaults to asc
  public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }

  // the current field to sort by. defaults to last name
  public String sortField {
    get  { if (sortField == null) {sortField = 'lastName'; } return sortField;  }
    set;
  }

  // format the soql for display on the visualforce page
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20'; }
    set;
  }

  // init the controller and display some sample data when the page loads
  public jeffDouglasDynamicSearch() {
    soql = 'select firstname, lastname, account.name, Phone from contact where account.name != null';
    runQuery();
  }

  // toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
    runQuery();
  }

  // runs the actual query
  public void runQuery() {

    try {
      contacts = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }

  // runs the search with parameters passed via Javascript
  public PageReference runSearch() {

    String firstName = Apexpages.currentPage().getParameters().get('firstname');
    String lastName = Apexpages.currentPage().getParameters().get('lastname');
    String accountName = Apexpages.currentPage().getParameters().get('accountName');
    //String technology = Apexpages.currentPage().getParameters().get('technology');

    soql = 'select firstname, lastname, account.name, interested_technologies__c from contact where account.name != null';
    if (!firstName.equals(''))
    soql += ' and firstname LIKE \''+String.escapeSingleQuotes(firstName)+'%\'';
    if (!lastName.equals(''))
    soql += ' and lastname LIKE \''+String.escapeSingleQuotes(lastName)+'%\'';
    if (!accountName.equals(''))
    soql += ' and account.name LIKE \''+String.escapeSingleQuotes(accountName)+'%\''; 
    //if (!technology.equals(''))
    //soql += ' and interested_technologies__c includes (\''+technology+'\')';

    // run the query again
    runQuery();

    return null;
  }
 public String selectedCountry2{get;set;}
    public List<SelectOption> getCountriesOptions() {
        List<SelectOption> countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('','--NONE--'));
        countryOptions.add(new SelectOption('YESTERDAY','YESTERDAY'));
        countryOptions.add(new SelectOption('Today','Today'));
        countryOptions.add(new SelectOption('TOMORROW','TOMORROW'));
        countryOptions.add(new SelectOption('LAST_WEEK','LAST_WEEK'));
        countryOptions.add(new SelectOption('THIS_WEEK','THIS_WEEK'));
        countryOptions.add(new SelectOption('NEXT_WEEK','NEXT_WEEK'));
        countryOptions.add(new SelectOption('LAST_MONTH','LAST_MONTH'));
        countryOptions.add(new SelectOption('THIS_MONTH','THIS_MONTH'));
        countryOptions.add(new SelectOption('NEXT_MONTH','NEXT_MONTH'));
    
    
        return countryOptions;
    }
    
    public List<Contact> contactList {
        get {
            if (contactList == null) {
                contactList = [SELECT Account.Name, FirstName, LastName, Phone FROM Contact limit 10000];
            }
            return contactList;
        }
        set;
    }
    
    public List<Account> accountList {
        get {
            if (accountList == null) {
                accountList = [SELECT Name, Fax, Phone, (SELECT FirstName, LastName, Phone FROM Contacts) FROM Account limit 10000];
            }
            return accountList;
        }
        set;
    }

}