$PBExportHeader$w_add.srw
forward
global type w_add from window
end type
type cb_delete from commandbutton within w_add
end type
type dw_data from datawindow within w_add
end type
type st_3 from statictext within w_add
end type
type st_2 from statictext within w_add
end type
type st_1 from statictext within w_add
end type
type sle_key from singlelineedit within w_add
end type
type sle_account from singlelineedit within w_add
end type
type sle_appname from singlelineedit within w_add
end type
type cbx_base32 from checkbox within w_add
end type
type cb_update from commandbutton within w_add
end type
type cb_add from commandbutton within w_add
end type
end forward

global type w_add from window
integer width = 2816
integer height = 1644
boolean titlebar = true
string title = "Config"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_delete cb_delete
dw_data dw_data
st_3 st_3
st_2 st_2
st_1 st_1
sle_key sle_key
sle_account sle_account
sle_appname sle_appname
cbx_base32 cbx_base32
cb_update cb_update
cb_add cb_add
end type
global w_add w_add

on w_add.create
this.cb_delete=create cb_delete
this.dw_data=create dw_data
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_key=create sle_key
this.sle_account=create sle_account
this.sle_appname=create sle_appname
this.cbx_base32=create cbx_base32
this.cb_update=create cb_update
this.cb_add=create cb_add
this.Control[]={this.cb_delete,&
this.dw_data,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_key,&
this.sle_account,&
this.sle_appname,&
this.cbx_base32,&
this.cb_update,&
this.cb_add}
end on

on w_add.destroy
destroy(this.cb_delete)
destroy(this.dw_data)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_key)
destroy(this.sle_account)
destroy(this.sle_appname)
destroy(this.cbx_base32)
destroy(this.cb_update)
destroy(this.cb_add)
end on

event open;If FileExists( "data.xml") Then
	dw_data.ImportFile( "data.xml")
End If


end event

type cb_delete from commandbutton within w_add
integer x = 750
integer y = 636
integer width = 283
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete"
end type

event clicked;If dw_data.GetRow() > 0 Then
	dw_data.DeleteRow(dw_data.GetRow())
	dw_data.SaveAs("data.xml", XML!, False)
End If

end event

type dw_data from datawindow within w_add
integer x = 50
integer y = 784
integer width = 2702
integer height = 720
integer taborder = 40
string title = "none"
string dataobject = "d_data"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;String ls_appname, ls_account, ls_key, ls_base

ls_appname = This.GetItemString(This.GetRow(), "appname")
ls_account = This.GetItemString(This.GetRow(), "account")
ls_key = This.GetItemString(This.GetRow(), "key")
ls_base = This.GetItemString(This.GetRow(), "base")

sle_appname.Text = ls_appname
sle_account.Text = ls_account
sle_key.Text = ls_key

If ls_base = "1" Then
	cbx_base32.Checked = True
Else
	cbx_base32.Checked = False
End If


end event

event constructor;Long ll_columns,ll_i
String ls_colName
ll_columns = Long(This.Object.DataWindow.Column.Count)
 
For ll_i = 1 To ll_columns
	ls_colName = This.Describe( "#" + String( ll_i ) + ".Name" )
	This.Modify(ls_colName+".Background.Color='255~t if(Getrow() = currentRow(),11665407,if(mod(getrow(),2 ) =0,rgb(231, 255, 231),rgb(255,255,255)))'")
Next
end event

type st_3 from statictext within w_add
integer x = 73
integer y = 396
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Key:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_add
integer x = 73
integer y = 244
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Account:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_add
integer x = 73
integer y = 88
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "App Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_key from singlelineedit within w_add
integer x = 443
integer y = 360
integer width = 2149
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_account from singlelineedit within w_add
integer x = 443
integer y = 216
integer width = 2149
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_appname from singlelineedit within w_add
integer x = 443
integer y = 68
integer width = 2149
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_base32 from checkbox within w_add
integer x = 453
integer y = 516
integer width = 690
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Key Base32 Encode"
end type

type cb_update from commandbutton within w_add
integer x = 434
integer y = 636
integer width = 283
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Update"
end type

event clicked;String ls_appname, ls_account, ls_key, ls_base

ls_appname = sle_appname.Text
ls_account = sle_account.Text
ls_key = sle_key.Text

If cbx_base32.Checked  Then
	ls_base = "1"
Else
	ls_base = "0"
End If

dw_data.SetItem(dw_data.GetRow(), "appname",ls_appname )
dw_data.SetItem(dw_data.GetRow(), "account", ls_account)
dw_data.SetItem(dw_data.GetRow(), "key", ls_key)
dw_data.SetItem(dw_data.GetRow(), "base", ls_base)


dw_data.SaveAs("data.xml", XML!, false)
end event

type cb_add from commandbutton within w_add
integer x = 123
integer y = 632
integer width = 283
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Add"
end type

event clicked;String ls_appname, ls_account, ls_key, ls_base

ls_appname = sle_appname.Text
ls_account = sle_account.Text
ls_key = sle_key.Text

If cbx_base32.Checked  Then
	ls_base = "1"
Else
	ls_base = "0"
End If

dw_data.ScrollToRow( dw_data.InsertRow(0) )
dw_data.SetItem(dw_data.GetRow(), "appname",ls_appname )
dw_data.SetItem(dw_data.GetRow(), "account", ls_account)
dw_data.SetItem(dw_data.GetRow(), "key", ls_key)
dw_data.SetItem(dw_data.GetRow(), "base", ls_base)


dw_data.SaveAs("data.xml", XML!, false)
end event

