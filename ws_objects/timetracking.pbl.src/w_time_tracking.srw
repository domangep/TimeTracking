$PBExportHeader$w_time_tracking.srw
forward
global type w_time_tracking from window
end type
type pb_edit from picturebutton within w_time_tracking
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
type dw_2 from datawindow within w_time_tracking
end type
end forward

global type w_time_tracking from window
integer width = 3758
integer height = 1292
boolean titlebar = true
string title = "Time tracking"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "Application5!"
boolean center = true
event ue_open ( )
event ue_save ( string filename )
event ue_add ( )
event ue_delete ( )
event ue_edit ( )
event ue_copy ( )
event ue_copyjira ( )
event ue_context_menu ( )
pb_edit pb_edit
pb_delete pb_delete
pb_add pb_add
dw_1 dw_1
pb_quit pb_quit
pb_save pb_save
pb_open pb_open
dw_2 dw_2
end type
global w_time_tracking w_time_tracking

type variables
Protected:
constant integer	CST_RUNNING 		= 1
constant integer	CST_PAUSED		= 2
constant integer	CST_STOP			= 3
constant integer	CST_FINISHED		= 4

boolean	ib_edit

string is_null
string is_docpath
string is_docname
end variables

forward prototypes
public subroutine of_start (long row)
public subroutine of_pause (long row)
public subroutine of_stop (long row)
public subroutine of_finish (long row)
public function integer of_checkpendingchanges ()
public function integer of_getjiratime (long row, ref string jiratime)
end prototypes

event ue_open();integer li_rc

timer(0)

if this.of_checkpendingchanges( ) = 1 then
	this.event ue_save(is_docpath)
end if

li_rc = getfileopenname( "Select file", is_docpath, is_docname, "xml", "XML files (*.xml),*.xml" )
if li_rc < 1 then return 

dw_1.reset()
dw_1.importfile(is_docpath, xml!)
dw_1.resetupdate( )

dw_1.sharedata(dw_2)

this.title = "Time tracking - " + is_docpath

end event

event ue_save(string filename);dw_1.accepttext( )
dw_1.saveas(filename,xml!,true)
dw_1.resetupdate( )
end event

event ue_add();dw_1.Scrolltorow(dw_1.insertrow(0))
dw_1.Setcolumn(1)
dw_1.SetFocus()
end event

event ue_delete();integer li_rc

li_rc = messagebox("Delete row ?","Are-you sure you want to delete the task labelled " + string( dw_1.object.task[dw_1.getrow()]) + " ?", exclamation!, yesno!)
if li_rc = 2 then return 

dw_1.deleterow(0)
dw_1.setfocus()
end event

event ue_edit();ib_edit = not( ib_edit )

dw_1.visible = not ib_edit
dw_2.visible = ib_edit

if ib_edit then
	timer(0)
	dw_2.setfocus()
else
	timer(1)
	dw_1.setfocus()
end if

dw_1.accepttext()
end event

event ue_copyjira();integer	li_rc
long		ll_row
string 	ls_jiratime

ll_row = dw_1.getrow()
if ll_row < 1 then return 

li_rc = of_getjiratime( ll_row, ls_jiratime )

clipboard( ls_jiratime )
end event

event ue_context_menu();m_contextual lm_menu

lm_menu = create m_contextual

lm_menu.m_edit.popmenu( pointerx(), pointery() )
end event

public subroutine of_start (long row);dw_1.object.status[row] = cst_running
timer(1)
end subroutine

public subroutine of_pause (long row);dw_1.object.status[row] = cst_paused
end subroutine

public subroutine of_stop (long row);dw_1.object.status[row] = cst_stop
end subroutine

public subroutine of_finish (long row);dw_1.object.status[row] = cst_finished

end subroutine

public function integer of_checkpendingchanges ();integer li_rc

if dw_1.modifiedcount( ) > 0 or dw_1.deletedcount( ) > 0 then
	li_rc = Messagebox("Save changes ?","Changes are pending do you want to save them ?", exclamation!, yesno! )
end if

return li_rc

end function

public function integer of_getjiratime (long row, ref string jiratime);integer	li_days
integer	li_hours
integer	li_minutes
integer	li_weeks
long		ll_seconds
string		ls_jiratime

if isnull( row) or row < 1 or row > dw_1.rowcount( ) then return -1

ll_seconds   = long( dw_1.object.days[row] ) * ( 3 * 8 * 3600 )
ll_seconds += long( dw_1.object.hours[row] ) * 3600
ll_seconds += long( dw_1.object.minutes[row] ) * 60
ll_seconds  += long( dw_1.object.seconds[row] )

li_weeks = ll_seconds / ( 5 * 8 * 3600 )
ll_seconds -= li_weeks * ( 5 * 8 * 3600 )

li_days = ll_seconds / (8 * 3600)
ll_seconds -=  li_days * (8 * 3600)

li_hours = ll_seconds / 3600
ll_seconds -= li_hours * 3600

li_minutes = ll_seconds / 60
ll_seconds -= li_minutes * 60

if li_weeks > 0 then
	ls_jiratime = string(li_weeks)+"w "
end if

if li_days > 0 then
	ls_jiratime += string(li_days )+"d "
end if

if li_hours > 0 then
	ls_jiratime += string(li_hours )+"h "
end if

if li_minutes > 0 then
	ls_jiratime += string(li_minutes )+"m "
end if

jiratime = ls_jiratime

return 1

end function

on w_time_tracking.create
this.pb_edit=create pb_edit
this.pb_delete=create pb_delete
this.pb_add=create pb_add
this.dw_1=create dw_1
this.pb_quit=create pb_quit
this.pb_save=create pb_save
this.pb_open=create pb_open
this.dw_2=create dw_2
this.Control[]={this.pb_edit,&
this.pb_delete,&
this.pb_add,&
this.dw_1,&
this.pb_quit,&
this.pb_save,&
this.pb_open,&
this.dw_2}
end on

on w_time_tracking.destroy
destroy(this.pb_edit)
destroy(this.pb_delete)
destroy(this.pb_add)
destroy(this.dw_1)
destroy(this.pb_quit)
destroy(this.pb_save)
destroy(this.pb_open)
destroy(this.dw_2)
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
	if long( dw_1.object.status[ll_i]) = cst_running then
		
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

event closequery;timer(0)
 
if this.of_checkpendingchanges( ) = 1 then
	this.post event ue_save(is_docpath)
	return 1
end if

end event

type pb_edit from picturebutton within w_time_tracking
integer x = 18
integer y = 212
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
string picturename = "Edit_2!"
alignment htextalign = left!
end type

event clicked;parent.event ue_edit()

end event

type pb_delete from picturebutton within w_time_tracking
integer x = 18
integer y = 612
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
integer x = 18
integer y = 412
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
integer x = 261
integer y = 16
integer width = 3461
integer height = 1172
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
		parent.of_start( row )
	case 'b_pause'
		parent.of_pause( row )
	case 'b_stop'
		parent.of_stop( row )
	case 'b_finish'
		parent.of_finish( row )
end choose

end event

event rbuttondown;parent.event ue_context_menu()
end event

type pb_quit from picturebutton within w_time_tracking
integer x = 18
integer y = 1012
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
integer x = 18
integer y = 812
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

event clicked;parent.event ue_save(is_docpath)
end event

type pb_open from picturebutton within w_time_tracking
integer x = 18
integer y = 12
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

type dw_2 from datawindow within w_time_tracking
integer x = 261
integer y = 16
integer width = 3461
integer height = 1172
integer taborder = 60
string title = "none"
string dataobject = "d_tracking_time_edit"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;parent.event ue_context_menu()

end event

