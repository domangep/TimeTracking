$PBExportHeader$timetracking.sra
$PBExportComments$Generated Application Object
forward
global type timetracking from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type timetracking from application
string appname = "timetracking"
long richtextedittype = 0
long richtexteditversion = 0
string richtexteditkey = ""
end type
global timetracking timetracking

type variables

end variables

on timetracking.create
appname="timetracking"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on timetracking.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open(w_time_tracking)
end event

