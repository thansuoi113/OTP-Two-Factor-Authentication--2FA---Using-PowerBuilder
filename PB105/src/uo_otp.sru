$PBExportHeader$uo_otp.sru
forward
global type uo_otp from userobject
end type
type p_copy from picture within uo_otp
end type
type st_time from statictext within uo_otp
end type
type p_qrcode from picture within uo_otp
end type
type st_appname from statictext within uo_otp
end type
type hpb_process from hprogressbar within uo_otp
end type
type st_account from statictext within uo_otp
end type
type st_pin from statictext within uo_otp
end type
type ov_1 from oval within uo_otp
end type
end forward

global type uo_otp from userobject
integer width = 1221
integer height = 580
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
p_copy p_copy
st_time st_time
p_qrcode p_qrcode
st_appname st_appname
hpb_process hpb_process
st_account st_account
st_pin st_pin
ov_1 ov_1
end type
global uo_otp uo_otp

type variables
Private:
String is_key = ""
String is_appname = ""
String is_account = ""
Boolean ib_keytypebase32 = false
uo_timing iuo_timing
end variables

forward prototypes
public subroutine of_start ()
public subroutine of_ini (string as_key, string as_appname, string as_account, boolean ab_keytypebase32)
end prototypes

public subroutine of_start ();//====================================================================
// Function: uo_otp.of_start()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: uo_otp.of_start ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Int li_Second
If IsNull(is_key) Or Len(Trim(is_key)) = 0 Then Return
li_Second = Integer(String(Now(), "ss"))
If Mod(li_Second, 30) = 0 Then
	
	String ls_pin
	nvo_authenticator lnv_pin
	
	ls_pin = lnv_pin.generatepin( is_key, ib_keytypebase32 )
	
	st_pin.Text = ls_pin
	
End If

hpb_process.Position = Mod((60 - li_Second) , 30)
st_time.Text = String(Mod((60 - li_Second) , 30))


end subroutine

public subroutine of_ini (string as_key, string as_appname, string as_account, boolean ab_keytypebase32);//====================================================================
// Function: uo_otp.of_ini()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	as_key          	
// 	value	string 	as_appname      	
// 	value	string 	as_account      	
// 	value	boolean	ab_keytypebase32	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2022/05/30
//--------------------------------------------------------------------
// Usage: uo_otp.of_ini ( string as_key, string as_appname, string as_account, boolean ab_keytypebase32 )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

is_key = as_key
is_appname = as_appname
is_account = as_account
ib_keytypebase32 = ab_keytypebase32

st_appname.Text = "App Name: " + is_appname
st_account.Text = "Account: " + is_account

If Not IsNull(is_account) And Len(Trim(is_account)) > 0 Then
	nvo_authenticator lnv_pin
	st_pin.Text = lnv_pin.generatepin( is_key, ib_keytypebase32 )
End If


end subroutine

on uo_otp.create
this.p_copy=create p_copy
this.st_time=create st_time
this.p_qrcode=create p_qrcode
this.st_appname=create st_appname
this.hpb_process=create hpb_process
this.st_account=create st_account
this.st_pin=create st_pin
this.ov_1=create ov_1
this.Control[]={this.p_copy,&
this.st_time,&
this.p_qrcode,&
this.st_appname,&
this.hpb_process,&
this.st_account,&
this.st_pin,&
this.ov_1}
end on

on uo_otp.destroy
destroy(this.p_copy)
destroy(this.st_time)
destroy(this.p_qrcode)
destroy(this.st_appname)
destroy(this.hpb_process)
destroy(this.st_account)
destroy(this.st_pin)
destroy(this.ov_1)
end on

event constructor;iuo_timing = Create uo_timing
iuo_timing.of_ini( This)
iuo_timing.Start( 1)

end event

event destructor;Destroy iuo_timing

end event

type p_copy from picture within uo_otp
integer x = 809
integer y = 336
integer width = 73
integer height = 72
boolean originalsize = true
string picturename = "copy.bmp"
boolean focusrectangle = false
end type

event clicked;String ls_pin

ls_pin = st_pin.Text
Clipboard (ls_pin)
MessageBox("infor", "Pin Your Copied: "  + ls_pin)
end event

type st_time from statictext within uo_otp
integer x = 1006
integer y = 340
integer width = 137
integer height = 96
integer textsize = -15
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "30"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_qrcode from picture within uo_otp
integer x = 978
integer y = 20
integer width = 197
integer height = 152
string pointer = "HyperLink!"
string picturename = "qrcode.bmp"
boolean border = true
boolean focusrectangle = false
end type

event clicked;string ls_qrcode, ls_app
nvo_authenticator lnv_pin

ls_app  = is_appname + ':' + is_account
ls_qrcode = lnv_pin.generateprovisioningimage (ls_app, is_key, ib_keytypebase32 )

if FileExists ( ls_qrcode ) then
	OpenWithParm (w_qrcode, ls_qrcode)
end if
end event

type st_appname from statictext within uo_otp
integer x = 32
integer y = 20
integer width = 896
integer height = 124
integer textsize = -15
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "App Name: PMIT"
boolean focusrectangle = false
end type

type hpb_process from hprogressbar within uo_otp
integer x = 32
integer y = 468
integer width = 896
integer height = 68
unsignedinteger maxposition = 30
unsignedinteger position = 1
integer setstep = 1
end type

type st_account from statictext within uo_otp
integer x = 32
integer y = 168
integer width = 896
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Account: pb.baoga"
boolean focusrectangle = false
end type

type st_pin from statictext within uo_otp
integer x = 32
integer y = 276
integer width = 896
integer height = 172
integer textsize = -28
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "123456"
boolean focusrectangle = false
end type

event clicked;String ls_pin

ls_pin = This.Text
Clipboard (ls_pin)
MessageBox("infor", "Pin Your Copied: "  + ls_pin)

end event

type ov_1 from oval within uo_otp
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 974
integer y = 304
integer width = 210
integer height = 172
end type

