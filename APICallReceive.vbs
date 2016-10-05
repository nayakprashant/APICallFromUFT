'
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
