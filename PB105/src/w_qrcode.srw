$PBExportHeader$w_qrcode.srw
forward
global type w_qrcode from window
end type
type p_qrcode from picture within w_qrcode
end type
end forward

global type w_qrcode from window
integer width = 974
integer height = 948
boolean titlebar = true
string title = "QRCode"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_qrcode p_qrcode
end type
global w_qrcode w_qrcode

on w_qrcode.create
this.p_qrcode=create p_qrcode
this.Control[]={this.p_qrcode}
end on

on w_qrcode.destroy
destroy(this.p_qrcode)
end on

event open;String ls_StringParm

ls_StringParm = Message.StringParm

If Not  IsNull(ls_StringParm) And Len(Trim(ls_StringParm)) > 0 Then
	p_qrcode.PictureName = ls_StringParm
End If

end event

type p_qrcode from picture within w_qrcode
integer x = 9
integer width = 946
integer height = 856
boolean originalsize = true
boolean focusrectangle = false
end type

