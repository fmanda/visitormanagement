create table visitor(
	id serial primary key,
	visitorname varchar(150),
	phone varchar(50),
	company varchar(150),
	address varchar(255),
	idcardno varchar(100),
	lastvisit_id int
)

create table department(
	id serial primary key,
	deptname varchar(150)
)

create table users(
	id serial primary key,
	username varchar(150),
	userpassword varchar(10)
)

create table visit(
	id serial primary key,
	visitor_id int,
	entrydate timestamp without time zone,
	exitdate timestamp without time zone,
	dept_id int,
	person_to_meet varchar(150),
	reason varchar(255),
	img_path varchar(255),
	user_id int
)

create table testheader(
	id serial primary key,
	code varchar(150)
)

create table testdetail(
	header_id int,
	detailcode varchar(150)
)

create table visitimage(
	visit_id int,
	img1 BYTEA,
	img2 BYTEA,
	imgpath1 varchar(300)
)

# prepare
- design db (ok)

# backend
- server->classes->DB migrate to PGSQL (ok)
- api testing (ok)
- server->models (ok)

# frontend
- clean up interface
- interface
- crud test
- webcam
- finishing


{
  "entrydate" : "2022-9-4 00:00:00",
  "exitdate" : "2022-9-4 00:00:00",
  "person_to_meet" : "nami",
  "reason" : "gaming again",
  "dept_id" : 0,
  "user_id" : 0,
  "visitor" : {
     "visitorname" : "fmanda2",
     "address" : "mendungan2",
     "idcardno" : "xxxx2"
  }
}


{
  "entrydate" : "2022-9-4 00:00:00",
  "exitdate" : "2022-9-4 00:00:00",
  "person_to_meet" : "nami",
  "reason" : "gaming again",
  "dept_id" : 0,
  "user_id" : 0,
  "visitor_id" : 1
}
