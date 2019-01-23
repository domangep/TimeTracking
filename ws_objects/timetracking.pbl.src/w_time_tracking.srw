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
type pb_saveas from picturebutton within w_time_tracking
end type
type pb_save from picturebutton within w_time_tracking
end type
type pb_open from picturebutton within w_time_tracking
end type
end forward

global type w_time_tracking from window
integer width = 3703
integer height = 1288
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
event ue_saveas ( )
event ue_add ( )
event ue_delete ( )
pb_delete pb_delete
pb_add pb_add
dw_1 dw_1
pb_quit pb_quit
pb_saveas pb_saveas
pb_save pb_save
pb_open pb_open
end type
global w_time_tracking w_time_tracking

type variables
Protected:
string is_null

end variables
event ue_open();dw_1.importfile(is_null)

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

on w_time_tracking.create
this.pb_delete=create pb_delete
this.pb_add=create pb_add
this.dw_1=create dw_1
this.pb_quit=create pb_quit
this.pb_saveas=create pb_saveas
this.pb_save=create pb_save
this.pb_open=create pb_open
this.Control[]={this.pb_delete,&
this.pb_add,&
this.dw_1,&
this.pb_quit,&
this.pb_saveas,&
this.pb_save,&
this.pb_open}
end on

on w_time_tracking.destroy
destroy(this.pb_delete)
destroy(this.pb_add)
destroy(this.dw_1)
destroy(this.pb_quit)
destroy(this.pb_saveas)
destroy(this.pb_save)
destroy(this.pb_open)
end on

event open;SetNull( is_null )

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
integer height = 1176
integer taborder = 40
string title = "none"
string dataobject = "d_tracking_time"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_quit from picturebutton within w_time_tracking
integer y = 1000
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

type pb_saveas from picturebutton within w_time_tracking
integer y = 800
integer width = 215
integer height = 180
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean flatstyle = true
string picturename = "SaveAs!"
alignment htextalign = left!
end type

event clicked;parent.event ue_saveas()

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

