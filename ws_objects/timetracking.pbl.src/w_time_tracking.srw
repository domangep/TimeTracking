$PBExportHeader$w_time_tracking.srw
forward
global type w_time_tracking from window
end type
type pb_delete from picturebutton within w_time_tracking
end type
type pb_add from picturebutton within w_time_tracking
end type
type dw_1 from datawindow within w_time_tracking
end type
type pb_quit from picturebutton within w_time_tracking
end type
type pb_save from picturebutton within w_time_tracking
end type
type pb_open from picturebutton within w_time_tracking
end type
end forward

global type w_time_tracking from window
integer width = 3703
integer height = 1092
boolean titlebar = true
string title = "Time tracking"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_open ( )
event ue_save ( )
event ue_add ( )
event ue_delete ( )
pb_delete pb_delete
pb_add pb_add
dw_1 dw_1
pb_quit pb_quit
pb_save pb_save
pb_open pb_open
end type
global w_time_tracking w_time_tracking

type variables
Protected:
constant integer	CST_RUNNGING 	= 1
constant integer	CST_PAUSED		= 2
constant integer	CST_STOP			= 3
constant integer	CST_FINISHED		= 4

string is_null

end variables
forward prototypes
public subroutine of_start (long row)
public subroutine of_pause (long row)
public subroutine of_stop (long row)
public subroutine of_finish (long row)
end prototypes

event ue_open();dw_1.reset()
dw_1.importfile(is_null)
end event

event ue_save();dw_1.accepttext( )
dw_1.saveas(is_null)

end event

event ue_add();dw_1.insertrow(0)
dw_1.Setcolumn(1)
dw_1.SetFocus()

end event

event ue_delete();integer li_rc

li_rc = messagebox("Delete row ?","Are-you sure you want to delete this row ?", exclamation!, yesno!)
if li_rc = 2 then return 

dw_1.deleterow(0)
dw_1.setfocus()

end event

public subroutine of_start (long row);dw_1.object.status[row] = cst_runnging
timer(1)
end subroutine

public subroutine of_pause (long row);dw_1.object.status[row] = cst_paused
end subroutine

public subroutine of_stop (long row);dw_1.object.status[row] = cst_stop
end subroutine

public subroutine of_finish (long row);dw_1.object.status[row] = cst_finished

end subroutine

on w_time_tracking.create
this.pb_delete=create pb_delete
this.pb_add=create pb_add
this.dw_1=create dw_1
this.pb_quit=create pb_quit
this.pb_save=create pb_save
this.pb_open=create pb_open
this.Control[]={this.pb_delete,&
this.pb_add,&
this.dw_1,&
this.pb_quit,&
this.pb_save,&
this.pb_open}
end on

on w_time_tracking.destroy
destroy(this.pb_delete)
destroy(this.pb_add)
destroy(this.dw_1)
destroy(this.pb_quit)
destroy(this.pb_save)
destroy(this.pb_open)
end on

event open;SetNull( is_null )

end event

event timer;long 	ll_i
long 	ll_limit
long 	ll_days
long 	ll_hours
long	ll_minutes
long	ll_seconds

ll_limit = dw_1.rowcount()

for ll_i = 1 to ll_limit
	if long( dw_1.object.status[ll_i]) = cst_runnging then
		
		ll_days 		= long( dw_1.object.days[ll_i])
		ll_hours 		= long( dw_1.object.hours[ll_i])
		ll_minutes	= long( dw_1.object.minutes[ll_i])
		ll_seconds 	= long( dw_1.object.seconds[ll_i]) 
		
		ll_seconds++
		if ll_seconds = 60 then
			ll_seconds = 0
			ll_minutes ++
			if ll_minutes = 60 then
				ll_minutes = 0
				ll_hours ++
				if ll_hours = 24 then
					ll_hours = 0
					ll_days ++
				end if
			end if
		end if
		
		dw_1.object.days[ll_i]		= ll_days 
		dw_1.object.hours[ll_i]		= ll_hours
		dw_1.object.minutes[ll_i]	= ll_minutes
		dw_1.object.seconds[ll_i]	= ll_seconds
				
	end if
next
end event

type pb_delete from picturebutton within w_time_tracking
integer y = 400
integer width = 215
integer height = 180
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;parent.Event ue_delete()

end event

type pb_add from picturebutton within w_time_tracking
integer y = 200
integer width = 215
integer height = 180
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;parent.Event ue_add()
end event

type dw_1 from datawindow within w_time_tracking
integer x = 242
integer y = 4
integer width = 3410
integer height = 980
integer taborder = 40
string title = "none"
string dataobject = "d_tracking_time"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;if row < 1 then return

choose case dwo.name
	case 'b_start'
		
	case 'b_pause'
	case 'b_stop'
	case 'b_finish'
end choose

end event

type pb_quit from picturebutton within w_time_tracking
integer y = 800
integer width = 215
integer height = 180
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "Exit!"
alignment htextalign = left!
end type

event clicked;close(parent)

end event

type pb_save from picturebutton within w_time_tracking
integer y = 600
integer width = 215
integer height = 180
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;parent.event ue_save()

end event

type pb_open from picturebutton within w_time_tracking
integer width = 215
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "Open!"
alignment htextalign = left!
end type

event clicked;parent.event ue_open()

end event

