''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Author:		Prashant Nayak
'Date Created:	10/28/2016
'Function name:	invokeJSONApi
'Parameters:	strJSONResponseFilePath, strJSONResponseFileName, strJSONRequestURL, strRequestMetod, 
'				strJSONHeaders, strJSONRequest, strFutureUse
'Description:	This function will call RESTFul JSON API and store the response in the specified file
'				strJSONResponseFilePath - path where JSON response will be stored. 
'				Example: strJSONResponseFilePath = "D:\API_Response\“
'				strJSONResponseFileName - Name of the file in which the response needs to be saved. 
'				Example: strJSONResponseFileName = “JSONResponse.txt
'				strJSONRequestURL - Set the value of JSON API URL in this variable
'				Example: strJSONRequestURL = https://test.com/dataservices/dispatch/mobile/login
'				strRequestMetod - Set the API request method in the variable strRequestMetod. 
'				Example: strRequestMetod = "POST“
'				strJSONHeaders – Header name and value separated by a delimiter “:”
'				Each header should separated by a delimiter “|”
'				Example: strJSONHeaders = “Accept-Encoding:gzip,deflate|Content-type:application/json”
'				strJSONRequest - Set the JSON request as shown below
'				strJSONToSend = "{""versionNumber"": 46000999000, ""deviceOSVersion"": ""8.0}“
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function invokeJSONApi(byVal strJSONResponseFilePath, byVal strJSONResponseFileName, byVal strJSONRequestURL, byVal strRequestMetod,_
						byVal strJSONHeaders, byVal strJSONRequest, byVal strFutureUse)
	
	intTypeText             = 2
	intSaveCreateOverWrite  = 2
	strRequestMetod = "POST"
	
	'Create an object
	Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.6.0")
	
	'Open the desired JSON API request	
	oXMLHTTP.Open strRequestMetod, strJSONRequestURL, False
	
	'Set headers for the request
	arrHeaders = Split(strJSONHeaders, "|")
	For intHeaders = 0 To UBound(arrHeaders) Step 1
		arrHeader = Split(arrHeaders(intHeaders), ":")
		oXMLHTTP.setRequestHeader arrHeader(0), arrHeader(1)
	Next
	
	'Start the transaction
	starttime=Timer
	'Call the api
	oXMLHTTP.Send strJSONRequest
	endtime=Timer
	strResponseTime = endtime-starttime
	
	'Get the response and write to text file
	set oStream = createobject("adodb.stream")  
    oStream.type = intTypeText
    oStream.Charset="ascii"
    oStream.open
    oStream.writetext oXMLHTTP.ResponseText  
    oStream.Position=0
    oStream.savetofile  strJSONResponseFilePath&strJSONResponseFileName, intSaveCreateOverWrite
	
	'Release the memory
    Set oXMLHTTP = Nothing  
    Set oStream = Nothing
    
	invokeJSONApi = strResponseTime
	
End Function
