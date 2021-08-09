/*1. A retail store manager wants to organize their data into a relational database. Their data
mainly is about the customers and the purchased items. Each customer has a name, ID,
phone number, age, and each Item has item_ID, item_Price, item_Type.*/

CREATE TABLE "Customers" (
	"Name"	TEXT,
	"ID"	INTEGER NOT NULL,
	"Number"	INTEGER,
	"Age"	INTEGER,
	PRIMARY KEY("ID" AUTOINCREMENT)
);

CREATE TABLE "Items" (
	"item_ID"	INTEGER NOT NULL,
	"item_Price"	NUMERIC,
	"item_Type"	TEXT,
	PRIMARY KEY("item_ID" AUTOINCREMENT)
);

--Orders table that links both Customers and Items
CREATE TABLE Orders (
	'order_ID' INTEGER NOT NULL,
	'order_date' DATETIME,
	'cust_ID' INTEGER,
	'item_code' INTEGER,
	PRIMARY KEY('order_ID' AUTOINCREMENT),
	FOREIGN KEY('cust_ID') REFERENCES Customers('ID'),
	FOREIGN KEY('item_code') REFERENCES Items('item_ID')
);

/*2. At NPower Canada each participant has a Participant_ID, name, program_name.
Participants can register in multiple courses. Each course has a name, course_ID.
Multiple participants can register at the same course. Also, each instructor has a name
and ID. Instructors can supervise multiple participants, however participants can have
only one instructor.*/

CREATE TABLE Participants(
	'Participant_ID' INTEGER NOT NULL,
	'part_name' TEXT,
	'prog_name' TEXT,
	'instruc_name' TEXT,
	PRIMARY KEY('Participant_ID' AUTOINCREMENT),
	FOREIGN KEY('instruc_name') REFERENCES Instructors('inst_ID')
);

CREATE TABLE Courses(
	course_name TEXT,
	course_ID INTEGER NOT NULL,
	PRIMARY KEY('course_ID' AUTOINCREMENT)
);

CREATE TABLE Course_Registration(
	part_ID TEXT NOT NULL,
	cour_ID INTEGER NOT NULL,
	FOREIGN KEY('part_ID') REFERENCES Participants('Participant_ID'),
	FOREIGN KEY('cour_ID') REFERENCES Courses('course_ID'),
	UNIQUE('part_ID', 'cour_ID')
);

CREATE TABLE Instructors(
	inst_name TEXT,
	inst_ID INTEGER NOT NULL,
	PRIMARY KEY('inst_ID' AUTOINCREMENT)
);