public class RestAPIcalloutExample3{

   Public void loginToOtherOrgAndCreaetNewAccount(){
        /*Login to Other Salesforce Org to grab session id - begin*/
        HTTP h1 = new HTTP();
        HttpRequest request = new HttpRequest();       
        request.setEndpoint('https://login.salesforce.com/services/Soap/u/22.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + 'ganeshjujjuru@yahoo.com.trailhead'+ '</username><password>' +'welcome12#'+ '</password></login></Body></Envelope>');
        String SERVER_URL;
        String SESSION_ID;
        HTTPResponse loginResponse = h1.send(request);     
        Dom.Document doc = loginResponse.getBodyDocument();
        Dom.XMLNode receivedXml= doc.getRootElement();
        SESSION_ID = receivedXml.getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/').getChildElement('loginResponse', 'urn:partner.soap.sforce.com').getChildElement('result','urn:partner.soap.sforce.com').getChildElement('sessionId','urn:partner.soap.sforce.com') .getText();      
        /*Login to Other salesforce Org to grab session id - finish*/
      
        /* Send https request to the custom REST API defined in other org that has urlmapping as 'createNewAccountUsingRestAPI' -begin*/
        HTTP h2 = new HTTP();
        HttpRequest request2CreateAccount = new HttpRequest();
        request2CreateAccount.setMethod('POST');
        request2CreateAccount.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request2CreateAccount.setHeader('Accept', 'application/json');
        request2CreateAccount.setHeader('SOAPAction', '""');
        request2CreateAccount.setbody('{"name":"Cloudforce4u Technologies Ltd"}');
            request2CreateAccount.setEndpoint('https://ap2.salesforce.com/services/apexrest/createNewAccountUsingRestAPI');
        request2CreateAccount.setHeader('Authorization', 'OAuth '+SESSION_ID);             
        HTTPResponse resppnceFromOtherSFOrg = h2.send(request2CreateAccount);
        system.debug('00000SessionId0000='+SESSION_ID);
        /* Send https request to the custom REST API defined in other org that hass urlmapping as updateaccountrec - finish*/
        system.debug('**-Output-**'+resppnceFromOtherSFOrg.getbody());
   } 
 }