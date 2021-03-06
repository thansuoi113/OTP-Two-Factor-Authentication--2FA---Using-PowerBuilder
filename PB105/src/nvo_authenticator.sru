$PBExportHeader$nvo_authenticator.sru
forward
global type nvo_authenticator from nonvisualobject
end type
type time_zone_information from structure within nvo_authenticator
end type
type systemtime from structure within nvo_authenticator
end type
type hmac_info from structure within nvo_authenticator
end type
end forward

type time_zone_information from structure
	long		bias
	long		standardname[31]
	systemtime		standarddate
	long		standardbias
	long		daylightname[31]
	systemtime		daylighttime
	long		daylightbias
end type

type systemtime from structure
	integer		wyear
	integer		wmonth
	integer		wdayofweek
	integer		wday
	integer		whour
	integer		wminute
	integer		wsecond
	integer		wmilliseconds
end type

type hmac_info from structure
	unsignedlong		hashalgid
	unsignedlong		pbinnerstring
	unsignedlong		cbinnerstring
	unsignedlong		pbouterstring
	unsignedlong		cbouterstring
end type

global type nvo_authenticator from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetTimeZoneInformation (ref TIME_ZONE_INFORMATION lpTimeZoneInformation) Library "kernel32"
Function boolean TzSpecificLocalTimeToSystemTime(TIME_ZONE_INFORMATION lpTimeZone, SYSTEMTIME lpLocalTime, ref SYSTEMTIME lpUniversalTime) Library "kernel32"
Function String GetBase32Encode(String msg) Library "BaseEncoding.dll"  Alias For "GetBase32Encode;Ansi"
Function String GetBase32Decode(String coded) Library "BaseEncoding.dll"  Alias For "GetBase32Decode;Ansi"
Function String GetBase64Encode(String msg) Library "BaseEncoding.dll"  Alias For "GetBase64Encode;Ansi"
Function String GetBase64Decode(String coded) Library "BaseEncoding.dll"  Alias For "GetBase64Decode;Ansi"

Function ulong GetLastError () Library "kernel32.dll" 
Function ulong FormatMessage( ulong dwFlags, ulong lpSource, ulong dwMessageId, ulong dwLanguageId, Ref string lpBuffer, ulong nSize, ulong Arguments ) Library "kernel32.dll" Alias For "FormatMessageW"
Function boolean CloseHandle ( long hObject ) Library "kernel32.dll"
Function boolean TzSpecificLocalTimeToSystemTime ( long lpTimeZoneInformation, SYSTEMTIME lpLocalTime, Ref SYSTEMTIME lpUniversalTime ) Library "kernel32.dll"
Function boolean CryptBinaryToString ( blob pbBinary, ulong cbBinary, ulong dwFlags, Ref string pszString, Ref ulong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function boolean CryptBinaryToString ( blob pbBinary, ulong cbBinary, ulong dwFlags, long pszString, Ref ulong pcchString ) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
Function boolean CryptStringToBinary ( string pszString, ulong cchString, ulong dwFlags, Ref blob pbBinary, Ref ulong pcbBinary, Ref ulong pdwSkip, Ref ulong pdwFlags ) Library "crypt32.dll" Alias For "CryptStringToBinaryW"
Function ulong BCryptCloseAlgorithmProvider ( Ref long hAlgorithm, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptCreateHash ( long hAlgorithm, Ref long phHash, Ref blob pbHashObject, ulong cbHashObject, long pbSecret, ulong cbSecret, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptCreateHash ( long hAlgorithm, Ref long phHash, Ref blob pbHashObject, ulong cbHashObject, blob pbSecret, ulong cbSecret, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptDestroyHash ( Ref long hHash ) Library "bcrypt.dll"
Function ulong BCryptFinishHash ( long hHash, Ref blob pbOutput, ulong cbOutput, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptGenRandom ( long phAlgorithm, Ref long pbBuffer, ulong cbBuffer, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptGetProperty ( long hObject, string pszProperty, Ref long pbOutput, ulong cbOutput, Ref ulong pcbResult, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptHashData ( long hHash, blob pbInput, ulong cbInput, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptOpenAlgorithmProvider ( Ref long phAlgorithm, string pszAlgId, ulong pszImplementation, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptGenerateSymmetricKey ( long phAlgorithm, Ref long phKey, Ref blob pbKeyObject, ulong cbKeyObject, blob pbSecret, ulong cbSecret, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptDestroyKey ( Ref long hKey ) Library "bcrypt.dll"
Function ulong BCryptEncrypt ( long hKey, blob pbInput, ulong cbInput, long pPaddingInfo, blob pbIV, ulong cbIV, long pbOutput, ulong cbOutput, Ref ulong pcbResult, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptEncrypt ( long hKey, blob pbInput, ulong cbInput, long pPaddingInfo, blob pbIV, ulong cbIV, Ref blob pbOutput, ulong cbOutput, Ref ulong pcbResult, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptDecrypt ( long hKey, blob pbInput, ulong cbInput, long pPaddingInfo, blob pbIV, ulong cbIV, long pbOutput, ulong cbOutput, Ref ulong pcbResult, ulong dwFlags ) Library "bcrypt.dll"
Function ulong BCryptDecrypt ( long hKey, blob pbInput, ulong cbInput, long pPaddingInfo, blob pbIV, ulong cbIV, Ref blob pbOutput, ulong cbOutput, Ref ulong pcbResult, ulong dwFlags ) Library "bcrypt.dll"

FUNCTION Long CreateBmpFile(string fileName, string text, long errCorLvl, long borderSize, long scale) LIBRARY "QRCodeGenLibrary.dll"
end prototypes

type variables
Private:

// BCrypt Error Codes
Constant ULong STATUS_SUCCESS					= 0				// 0x00000000
Constant ULong STATUS_BUFFER_TOO_SMALL		= 3221225507	// 0xC0000023
Constant ULong STATUS_INVALID_BUFFER_SIZE = 3221225990	// 0xC0000206
Constant ULong STATUS_INVALID_HANDLE		= 3221225480	// 0xC0000008
Constant ULong STATUS_INVALID_PARAMETER	= 3221225485	// 0xC000000D
Constant ULong STATUS_NO_MEMORY				= 3221225495	// 0xC0000017
Constant ULong STATUS_NOT_FOUND				= 3221226021	// 0xC0000225
Constant ULong STATUS_NOT_SUPPORTED			= 3221225659	// 0xC00000BB

// Cryptography Primitive Property Identifiers
Constant String BCRYPT_BLOCK_LENGTH  = "BlockLength"
Constant String BCRYPT_OBJECT_LENGTH = "ObjectLength"
Constant String BCRYPT_HASH_LENGTH   = "HashDigestLength"

Constant ULong BCRYPT_ALG_HANDLE_HMAC = 8
Constant ULong BCRYPT_BLOCK_PADDING = 1

Constant ULong NULL = 0
Constant ULong CRYPT_STRING_BASE64 = 1
Constant ULong CRYPT_STRING_HEXRAW = 12
Constant Ulong CRYPT_STRING_NOCRLF = 1073741824	// 0x40000000

// constants for CreateFile API function
Constant Long INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ      = 2147483648
Constant ULong GENERIC_WRITE     = 1073741824
Constant ULong FILE_SHARE_READ   = 1
Constant ULong FILE_SHARE_WRITE  = 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

long il_hAlg
long il_hRanAlg
long il_hHash
long il_hKey

Public:

// CNG Algorithm Identifiers

// Hashing Algorithms
Constant String BCRYPT_MD2_ALGORITHM    = "MD2"
Constant String BCRYPT_MD4_ALGORITHM    = "MD4"
Constant String BCRYPT_MD5_ALGORITHM    = "MD5"
Constant String BCRYPT_SHA1_ALGORITHM   = "SHA1"
Constant String BCRYPT_SHA256_ALGORITHM = "SHA256"
Constant String BCRYPT_SHA384_ALGORITHM = "SHA384"
Constant String BCRYPT_SHA512_ALGORITHM = "SHA512"

// Encryption Algorithms
Constant String BCRYPT_AES_ALGORITHM		= "AES"
Constant String BCRYPT_DES_ALGORITHM		= "DES"
Constant String BCRYPT_DESX_ALGORITHM		= "DESX"
Constant String BCRYPT_RC2_ALGORITHM		= "RC2"
Constant String BCRYPT_3DES_ALGORITHM		= "3DES"
Constant String BCRYPT_3DES_112_ALGORITHM	= "3DES_112"

Constant ULong STATUS_USER_ERROR = 0

// public non-constant instance variables
String LastFunction
String LastErrText
ULong  LastErrCode
Encoding iEncoding = EncodingAnsi!

end variables

forward prototypes
public function integer longtobytearray (long al_data, ref byte a_data[])
public function byte bitwiseand (byte a_value1, byte a_value2)
public function long getunixepoch ()
public function integer of_copylongtobytes (long al_long, ref byte a_byte[4])
public function blob of_blob (byte a_byte[])
private subroutine of_finalcleanup ()
public function unsignedlong of_getlasterror (ref string as_msgtext)
private subroutine of_errorcleanup (string as_function)
private function boolean nt_success (unsignedlong ntstatus)
public function blob of_hmac (string as_algorithm, blob ablb_message, blob ablb_secret)
public function long get_qrcode_bitmap (string as_filename, string as_text, long al_errcorlvl, long al_bordersize, long al_scale)
public function long get_qrcode_bitmap (string as_filename, string as_text)
public function string generatepin (string key, boolean ab_keytypebase32)
public function string generatepin (string as_key, long counter, boolean ab_keytypebase32)
public function string generateprovisioningimage (string identifier, string as_key, boolean ab_keytypebase32)
end prototypes

public function integer longtobytearray (long al_data, ref byte a_data[]);//====================================================================
// Function: nvo_authenticator.longtobytearray()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long	al_data 	
// 	reference	byte	a_data[]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.longtobytearray ( long al_data, ref byte a_data[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

byte		l_data[4]
Long		l_len = 4
Integer	i, j

of_copylongtobytes ( al_data, l_data )

//pad with 4 zeros
For i = 1 To 4
	j = UpperBound(a_data) +1
	a_data[j] = 0
Next

//Copy over data in inverse order
For i = 4 To 1 Step -1
	j = UpperBound (a_data) + 1
	a_data[j] = l_data[i]
Next


Return 1

end function

public function byte bitwiseand (byte a_value1, byte a_value2);//====================================================================
// Function: nvo_authenticator.bitwiseand()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	byte	a_value1	
// 	value	byte	a_value2	
//--------------------------------------------------------------------
// Returns:  byte
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.bitwiseand ( byte a_value1, byte a_value2 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer li_i
Byte     lbyte_result, lbyte_factor

lbyte_result = 0
For li_i = 1 To 8
	
	If a_value1 = 0 Or a_value2 = 0 Then Exit
	
	If li_i = 1 Then
		lbyte_factor = 1
	Else
		lbyte_factor *= 2
	End If
	
	If Mod(a_value1, 2) = 1 And Mod(a_value2, 2) = 1 Then
		lbyte_result += lbyte_factor
	End If
	
	a_value1 /= 2
	a_value2 /= 2
Next

Return lbyte_result

end function

public function long getunixepoch ();//====================================================================
// Function: nvo_authenticator.getunixepoch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.getunixepoch ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long	days
Long	seconds
Long 	epoch
ULong rc1
Boolean rc2
TIME_ZONE_INFORMATION tzi
SYSTEMTIME local
SYSTEMTIME utc
DateTime	l_datetime_utc

rc1 = GetTimeZoneInformation(tzi)

//Convert PowerBuilder datetime to SYSTEMTIME
local.wYear = Year(Today())
local.wMonth = Month(Today())
local.wDay = Day(Today())
local.wHour = Hour(Now())
local.wMinute = Minute(Now())
local.wSecond = Second(Now())
local.wMilliseconds = 0

//Get the time in UTC
rc2 = TzSpecificLocalTimeToSystemTime(tzi, local, utc)

//Convert the UTC SYSTEMTIME back to a PowerBuilder datetime
l_datetime_utc = DateTime ( Date ( utc.wYear, utc.wMonth, utc.wDay ), Time ( utc.wHour, utc.wMinute, utc.wSecond ) )

days = DaysAfter ( Date ( '1970/01/01' ), Date ( l_datetime_utc ) )
seconds = SecondsAfter ( Time ( '00:00:00' ), Time ( l_datetime_utc ) )
epoch = ( days * 24 * 60 * 60 ) + seconds
Return epoch


end function

public function integer of_copylongtobytes (long al_long, ref byte a_byte[4]);//====================================================================
// Function: nvo_authenticator.of_copylongtobytes()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long	al_long  	
// 	reference	byte	a_byte[4]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_copylongtobytes ( long al_long, ref byte a_byte[4] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_long
Integer i = 1, j, li_byte[]

ll_long = al_long

Do While Truncate(ll_long / 256, 0) > 0
	li_byte[i] = Mod(ll_long, 256)
	i++
	ll_long = Truncate(ll_long/256, 0)
Loop

li_byte[i] = Mod(ll_long, 256)

For j = 1 To i
	a_byte[j] += Byte(String(li_byte[j]))
Next

Return 1

end function

public function blob of_blob (byte a_byte[]);//====================================================================
// Function: nvo_authenticator.of_blob()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	byte	a_byte[]	
//--------------------------------------------------------------------
// Returns:  blob
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_blob ( byte a_byte[] )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer i
Blob lblb

lblb = Blob ( Space(UpperBound(a_byte)), EncodingUTF8! )
for i = 1 to UpperBound(a_byte)
	SetByte(lblb, i, a_byte[i])
Next

Return lblb
end function

private subroutine of_finalcleanup ();//====================================================================
// Function: nvo_authenticator.of_finalcleanup()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_finalcleanup ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If il_hAlg > 0 Then
	BCryptCloseAlgorithmProvider(il_hAlg, 0)
End If

If il_hRanAlg > 0 Then
	BCryptCloseAlgorithmProvider(il_hRanAlg, 0)
End If

If il_hHash > 0 Then
	BCryptDestroyHash(il_hHash)
End If

If il_hKey > 0 Then
	BCryptDestroyKey(il_hKey)
End If


end subroutine

public function unsignedlong of_getlasterror (ref string as_msgtext);//====================================================================
// Function: nvo_authenticator.of_getlasterror()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference	string	as_msgtext	
//--------------------------------------------------------------------
// Returns:  unsignedlong
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_getlasterror ( ref string as_msgtext )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_error, lul_Size = 255

lul_error = GetLastError()

as_msgtext = Space(lul_Size)

FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, lul_error, LANG_NEUTRAL, as_msgtext, lul_Size, 0)

Return lul_error



end function

private subroutine of_errorcleanup (string as_function);//====================================================================
// Function: nvo_authenticator.of_errorcleanup()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_function	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_errorcleanup ( string as_function )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


LastFunction = as_function
LastErrCode  = of_GetLastError(LastErrText)

of_FinalCleanup()


end subroutine

private function boolean nt_success (unsignedlong ntstatus);//====================================================================
// Function: nvo_authenticator.nt_success()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	unsignedlong	ntstatus	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.nt_success ( unsignedlong ntstatus )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


LastErrCode = NTSTATUS

If NTSTATUS = 0 Then
	Return True
Else
	Return False
End If

end function

public function blob of_hmac (string as_algorithm, blob ablb_message, blob ablb_secret);//====================================================================
// Function: nvo_authenticator.of_hmac()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_algorithm	
// 	value	blob  	ablb_message	
// 	value	blob  	ablb_secret 	
//--------------------------------------------------------------------
// Returns:  blob
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.of_hmac ( string as_algorithm, blob ablb_message, blob ablb_secret )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Blob lblb_NullReturn, lblb_pbHashObject, lblb_pbHash
Long ll_cbHashObject, ll_cbHash
ULong lul_cbData

SetNull(lblb_NullReturn)

// open an algorithm handle
If Not NT_SUCCESS(BCryptOpenAlgorithmProvider(il_hAlg, &
	as_algorithm, Null, &
	BCRYPT_ALG_HANDLE_HMAC)) Then
	of_ErrorCleanup("BCryptOpenAlgorithmProvider")
	Return lblb_NullReturn
End If

// calculate the size of the buffer to hold the hash object
If Not NT_SUCCESS(BCryptGetProperty(il_hAlg, &
	BCRYPT_OBJECT_LENGTH, &
	ll_cbHashObject, 4, lul_cbData, 0)) Then
	of_ErrorCleanup("BCryptGetProperty BCRYPT_OBJECT_LENGTH")
	Return lblb_NullReturn
End If

lblb_pbHashObject = Blob(Space(ll_cbHashObject), iEncoding)

// calculate the length of the hash
If Not NT_SUCCESS(BCryptGetProperty(il_hAlg, &
	BCRYPT_HASH_LENGTH, &
	ll_cbHash, 4, lul_cbData, 0)) Then
	of_ErrorCleanup("BCryptGetProperty BCRYPT_HASH_LENGTH")
	Return lblb_NullReturn
End If

lblb_pbHash = Blob(Space(ll_cbHash), iEncoding)

// create a hash
If Not NT_SUCCESS(BCryptCreateHash(il_hAlg, &
	il_hHash, lblb_pbHashObject, &
	ll_cbHashObject, ablb_secret, Len(ablb_secret), 0)) Then
	of_ErrorCleanup("BCryptCreateHash")
	Return lblb_NullReturn
End If

// hash some data
If Not NT_SUCCESS(BCryptHashData(il_hHash, &
	ablb_Message, Len(ablb_Message), 0)) Then
	of_ErrorCleanup("BCryptHashData")
	Return lblb_NullReturn
End If

// close the hash
If Not NT_SUCCESS(BCryptFinishHash(il_hHash, &
	lblb_pbHash, ll_cbHash, 0)) Then
	of_ErrorCleanup("BCryptFinishHash")
	Return lblb_NullReturn
End If

// final cleanup
of_FinalCleanup()

Return lblb_pbHash

end function

public function long get_qrcode_bitmap (string as_filename, string as_text, long al_errcorlvl, long al_bordersize, long al_scale);// The function creates a BITMAP file with a QR code (the version of the QR code is selected automatically from 1 to 40) (Mask Pattern is selected automatically)
// Options:
// fileName Path and name of the file to be created (C: \ Temp \ qrCode.bmp) (UTF-16 encoding)
// text Text to encode (1-4096) (Limited to 4096 characters) (UTF-16 encoding)
// errCorLvl Error correction level (0-4).
// QR code has a special mechanism to increase the reliability of encrypted information storage.
// For codes created with the highest level of reliability, up to 30% of the surface can be damaged or erased,
// but they will save information and be read correctly.
// Increasing the level helps to increase the reliability of information storage,
// but leads to an increase in the size of the matrix code.
// 0 - Low (Allowable percentage of violations is about 7%)
// 1 - Medium (Allowable percentage of violations is about 15%)
// 2 - Quartile (Allowable percentage of violations is about 25%)
// 3 - High (Allowable percentage of violations is about 30%)
// borderSize Size of the white border around in modules (limited to 0-100)
// scale Unit size in pixels (limited to 1-100)
//
// Returned value:
// 0 - Successful execution
// 1 - Error fileName, or incorrect path, or error opening file
// 2 - Error text, incorrect length of the encoded text
// 3 - Error errCorLvl, wrong level of error correction
// 4 - Error borderSize, wrong border size
// 5 - Error scale, incorrect module size
// 6 - Error converting the encoding of the encoded text from UTF-16 to UTF-8 (the buffer for UTF-8 is also 4096 characters and it may not be enough)
// 7 - Error receiving QR code
return CreateBmpFile(as_fileName, as_text, al_errCorLvl, al_borderSize, al_scale);
 



 
end function

public function long get_qrcode_bitmap (string as_filename, string as_text);
//====================================================================
// Function: nvo_authenticator.get_qrcode_bitmap()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_filename	
// 	value	string	as_text    	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.get_qrcode_bitmap ( string as_filename, string as_text )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return get_qrcode_bitmap(as_fileName, as_text, 1, 4, 4);


end function

public function string generatepin (string key, boolean ab_keytypebase32);//====================================================================
// Function: nvo_authenticator.generatepin()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	key             	
// 	value	boolean	ab_keytypebase32	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.generatepin ( string key, boolean ab_keytypebase32 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long	TotalSeconds, CurrentInterval, IntervalLength = 30

TotalSeconds = getunixepoch()
CurrentInterval = TotalSeconds/IntervalLength

Return generatepin ( Key, CurrentInterval, ab_keytypebase32 )

end function

public function string generatepin (string as_key, long counter, boolean ab_keytypebase32);//====================================================================
// Function: nvo_authenticator.generatepin()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	as_key          	
// 	value	long   	counter         	
// 	value	boolean	ab_keytypebase32	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.generatepin ( string as_key, long counter, boolean ab_keytypebase32 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

byte		hashBytes[], counterBytes[], offset, selectedByte
Blob		counterHashBlob, counterBlob, keyBlob
String		counterHash, pin
Integer	li_count, i, pinLen
Long		selectedLong
Long		selectedMod
String		 ls_key

//Convert the counter to byte array and then to blob
longtobytearray ( counter, counterBytes )
counterBlob = of_blob ( counterBytes )

If ab_keytypebase32 Then
	ls_key = GetBase32Decode(as_key)
Else
	ls_key = as_key
End If

//Convert key to blob and has counter
keyBlob = Blob ( ls_key, EncodingUTF8! )
counterHashBlob = of_hmac("SHA1", counterBlob, keyBlob)

//Convert result back to byte array
Int li_max, li_idx
li_max = Len(counterHashBlob)
For li_idx = 1 To li_max
	hashBytes[li_idx] = Byte(BlobMid(counterHashBlob, li_idx, 1))
Next

//Get the last byte
li_count = UpperBound ( hashBytes )
//And use that to determine the offset into the byte array that we'll start with
offset = bitwiseand ( hashBytes[li_count], 15 )

//Calculate the selectedLong value using the selected bytes
For i = 1 To 4
	selectedByte = 	hashBytes[offset + i]
	Choose Case i
		Case 1
			//Strip the most significant bit
			selectedByte = bitwiseand ( selectedByte, 127 )
			selectedLong = selectedLong + selectedByte * 2^24
		Case 2
			selectedLong = selectedLong + selectedByte * 2^16
		Case 3
			selectedLong = selectedLong + selectedByte * 2^8
		Case 4
			selectedLong = selectedLong + selectedByte
	End Choose
Next

selectedMod = Mod ( selectedLong, 1000000 )

pin = String ( selectedMod )
pinLen = Len ( pin )
pin = Fill ( '0', 6 - pinLen ) + pin

Return pin



end function

public function string generateprovisioningimage (string identifier, string as_key, boolean ab_keytypebase32);//====================================================================
// Function: nvo_authenticator.generateprovisioningimage()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	identifier      	
// 	value	string 	as_key          	
// 	value	boolean	ab_keytypebase32	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: nvo_authenticator.generateprovisioningimage ( string identifier, string as_key, boolean ab_keytypebase32 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Blob	lblb_provision_url
String	 ls_keystring,  ls_provision_url
Long ll_retval
String ls_url
String ls_qrcode

If ab_keytypebase32 Then
	ls_keystring = as_key
Else
	ls_keystring = GetBase32Encode(  as_key)
End If

ls_provision_url = 'otpauth://totp/' + identifier + '?secret=' + ls_keystring
lblb_provision_url = Blob ( ls_provision_url, EncodingUTF8! )
ls_url = String(lblb_provision_url, EncodingUTF8!)

ls_qrcode = "qrcodeotp.bmp"
ll_retval = get_qrcode_bitmap(ls_qrcode, ls_url, 1, 5,  5)
If ll_retval = 0 Then
	Return ls_qrcode
Else
	Return ""
End If
Return ""


end function

on nvo_authenticator.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_authenticator.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

