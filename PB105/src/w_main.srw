$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type p_add from picture within w_main
end type
end forward

global type w_main from window
integer width = 2633
integer height = 2372
boolean titlebar = true
string title = "OTP Two Factor Authentication ( 2FA )"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_add p_add
end type
global w_main w_main

type variables
uo_otp iuo_otp[]
uo_otp iuo_otpnull[]

end variables
forward prototypes
public subroutine of_loadotp ()
end prototypes

public subroutine of_loadotp ();//remove objects
Int li_r
For li_r = 1 To UpperBound (iuo_otp)
	If IsValid( iuo_otp[li_r] ) Then
		This.CloseUserObject ( iuo_otp[li_r] )
	End If
Next

//reset
iuo_otp[] = iuo_otpnull[]

// add otp
If FileExists("data.xml" ) Then
	datastore lds
	lds = Create datastore
	lds.DataObject = "d_data"
	lds.ImportFile( "data.xml")
	If lds.RowCount() > 0 Then
		Int li_row, li_optrow, li_optcolumn
		Long lx, ly
		li_optrow = -1
		For li_row = 1 To lds.RowCount()
			
			iuo_otp[li_row] = Create uo_otp
			String ls_appname, ls_account, ls_key, ls_base
			Boolean lb_keytypebase32
			ls_appname = lds.GetItemString(li_row, "appname")
			ls_account = lds.GetItemString(li_row, "account")
			ls_key = lds.GetItemString(li_row, "key")
			ls_base = lds.GetItemString(li_row, "base")
			
			If ls_base = "1" Then
				lb_keytypebase32 = True
			Else
				lb_keytypebase32 = False
			End If
			
			iuo_otp[li_row].of_ini (ls_key, ls_appname,ls_account, lb_keytypebase32)
			iuo_otp[li_row].Border = True
			
			
			If Mod(li_row,2) = 0 Then
				li_optcolumn = 1
			Else
				li_optcolumn = 0
				li_optrow += 1
			End If
			lx = li_optcolumn * iuo_otp[li_row].Width  + ((li_optcolumn  + 1 )* 50)
			ly = li_optrow * ( iuo_otp[li_row].Height + 50) + 50
			
			This.OpenUserObject(iuo_otp[li_row], lx, ly)
		Next
	End If
End If




end subroutine

on w_main.create
this.p_add=create p_add
this.Control[]={this.p_add}
end on

on w_main.destroy
destroy(this.p_add)
end on

event resize;p_add.x = this.width - p_add.width - 60
p_add.y = this.height - p_add.height - 140
end event

event open;of_loadotp()
end event

type p_add from picture within w_main
integer x = 2341
integer y = 2076
integer width = 229
integer height = 180
string pointer = "HyperLink!"
string picturename = "add.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean map3dcolors = true
end type

event clicked;Open(w_add)
of_loadotp( )

end event

