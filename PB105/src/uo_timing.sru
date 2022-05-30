$PBExportHeader$uo_timing.sru
forward
global type uo_timing from timing
end type
end forward

global type uo_timing from timing
end type
global uo_timing uo_timing

type variables
PowerObject ipos
end variables

forward prototypes
public subroutine of_ini (powerobject pos)
end prototypes

public subroutine of_ini (powerobject pos);ipos = pos
end subroutine

on uo_timing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;If IsValid(ipos) Then
	ipos.Dynamic Function of_start()
End If

end event

