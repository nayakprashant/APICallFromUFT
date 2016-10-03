Function invokeJSONApi()
	
	intTypeText             = 2
	intSaveCreateOverWrite  = 2
	strJSONResponseFilePath = "D:\API_RnD\"
	strJSONRequestURL = "https://domainname.com/services/mobile/login"
	strRequestMetod = "POST"
	
	'Create an object
	Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.6.0")
	
	'Open the desired JSON API request	
	oXMLHTTP.Open strRequestMetod, strJSONRequestURL, False
	
	'Set headers for the request
	oXMLHTTP.setRequestHeader "Accept-Encoding", "gzip,deflate" 
    oXMLHTTP.setRequestHeader "Content-type", "application/json"  
    oXMLHTTP.setRequestHeader "Authorization", "Basic cwdDDWSamck3ws" 
	oXMLHTTP.setRequestHeader "Content-Length", "93"
	oXMLHTTP.setRequestHeader "Host", "domainname.com"
	oXMLHTTP.setRequestHeader "Connection", "Keep-Alive"
	oXMLHTTP.setRequestHeader "User-Agent", "Apache-HttpClient/4.1.1 (java 1.5)"
	
	strJSONToSend = "{""versionNumber"": 0999000, ""deviceOSVersion"": ""8.0""}"
	
	'Call the api
	oXMLHTTP.Send strJSONToSend
	
	'Get the response and write to text file
	set oStream = createobject("adodb.stream")  
    oStream.type = intTypeText
    oStream.Charset="ascii"
    oStream.open
    oStream.writetext oXMLHTTP.ResponseText  
    oStream.Position=0
    oStream.savetofile  strJSONResponseFilePath&"json.txt", intSaveCreateOverWrite
	
	'Release the memory
    Set oXMLHTTP = Nothing  
    Set oStream = Nothing
    
    'Parse the JSON response
	Set fso = CreateObject("Scripting.Filesystemobject")
	strResponse = fso.OpenTextFile(strJSONResponseFilePath&"json.txt").ReadAll
	Set objParsedJSON = Decode(strResponse)

	Set invokeJSONApi = objParsedJSON
	
End Function
