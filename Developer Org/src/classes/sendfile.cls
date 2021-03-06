/* This code snippet performs a multipart/form-data HTTP request from Apex to Docparser. */
/* Creating multipart/form-dat requests is unfortunately quite complex in Apex. */
/* If you interested in more details, please visit: https://docparser.com/blog/post-file-salesforce-apex-external-http-webservices/
/* Code generously provided by Theertha Prasad */

// Don't forget to add remote site settings

public class sendfile {

public static void send(){
Attachment objPDF = [SELECT ID,Name,Body FROM Attachment Where Id = '00P1I000005F5dG']; // Add id filter to get proper pdf attachment
// change the following variables according to your use-case
String strApiKey = '43c619ba31e1afa5b0aeb5ee8052fdf48b21121c';
String strParserId = 'ljefqbqkfzmd';
String strTargetURL = 'https://api.docparser.com/v1/document/upload/' + strParserId + '?remote_id='+objPDF.Id;
String strSeparationKey = 'A_RANDOM_STRING';

// assemble the body payload
String strHeader = '--' + strSeparationKey + '\nContent-Disposition: form-data; name="file"; filename="' + objPDF.Name + '"\nContent-Type: application/octet-stream\n\n';
String strBody = EncodingUtil.base64Encode(objPDF.Body);
String strFooter = '\n--' + strSeparationKey + '--';

String strHeaderEncoded = EncodingUtil.base64Encode(Blob.valueOf(strHeader+'\n'));
while(strHeaderEncoded.endsWith('=')) {
strHeader+=' ';
strHeaderEncoded = EncodingUtil.base64Encode(Blob.valueOf(strHeader+'\n'));
}
String strBodyEncoded = strBody;
String strFooterEncoded = EncodingUtil.base64Encode(Blob.valueOf(strFooter));

Blob blobBody = null;
String last4Bytes = strBodyEncoded.substring(strBodyEncoded.length()-4,strBodyEncoded.length());

if(last4Bytes.endsWith('=')) {
Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
HttpRequest objHttpRequest = New HttpRequest();
objHttpRequest.setBodyAsBlob(decoded4Bytes);
String last4BytesFooter = objHttpRequest.getBody()+strFooter;
blobBody = EncodingUtil.base64Decode(strHeaderEncoded+strBodyEncoded.substring(0,strBodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
} else {
blobBody = EncodingUtil.base64Decode(strHeaderEncoded+strBodyEncoded+strFooterEncoded);
}

if(blobBody.size()>3000000) {
// throw new CustomException('File size limit is 3 MBytes');
system.debug('File size limit is 3 MBytes');
}else{
system.debug('blobBody.size()'+blobBody.size());
}

// send out the request
HttpRequest req = New HttpRequest();
req.setHeader('Content-Type', 'multipart/form-data; boundary=' + strSeparationKey);
req.setHeader('Authorization', 'Basic ' + strApiKey);
req.setMethod('POST');
req.setEndpoint(strTargetURL);
req.setBodyAsBlob(blobBody);
req.setHeader('Content-Length', String.valueof(req.getBodyAsBlob().size()));
Http http = New Http();
HTTPResponse res = http.send(req);
system.debug('res'+res.getBody());
}
}