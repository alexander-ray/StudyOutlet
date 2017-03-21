CREATE DATABASE IF NOT EXISTS StudyOutlet;

USE StudyOutlet;

create table if not exists `Users` (
 `user_id` int(1) not null auto_increment,
 `username` varchar(45) not null,
 `password` varchar(45) not null,
 primary key (`user_id`)
);

create table if not exists `Questions` (
 `question_id` int(1) not null auto_increment,
 `question` mediumblob not null,
 `answer` varchar(1) not null,
 `solution` mediumblob not null,
 `subject` varchar(45) not null,
 `topic` varchar(45) not null,
 primary key(`question_id`)
);

create table if not exists `IncorrectQ`(
 `incorrectQ_id` int(1) not null,
 `question_id` int(1) not null,
 `user_id` int(1) not null,
 primary key(`incorrectQ_id`, `question_id` , `user_id`),
 foreign key(`user_id`) references Users(`user_id`),
 foreign key(`question_id`) references Questions(`question_id`)
);

INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE('/var/lib/mysql-files/images/Q1.png'),'B', LOAD_FILE('/var/lib/mysql-files/images/Q1sol.png'), 'Physics', 'Mechanics');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE('/var/lib/mysql-files/images/Q2.png'), 'D', LOAD_FILE('/var/lib/mysql-files/images/Q2sol.png'), 'Physics', 'E&M');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE('/var/lib/mysql-files/images/Q3.png'), 'B', LOAD_FILE('/var/lib/mysql-files/images/Q3sol.png'), 'Physics', 'Mechanics');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`)
	VALUES (LOAD_FILE('/var/lib/mysql-files/images/Q4.png'), 'A', LOAD_FILE('/var/lib/mysql-files/images/Q4sol.png'), 'Physics', 'E&M');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE('/var/lib/mysql-files/images/Q5.png'), 'C', LOAD_FILE('/var/lib/mysql-files/images/Q5sol.png'), 'Physics', 'Mechanics');
	
INSERT INTO `Users` (`username`, `password`)
	VALUES ('AlexRay', 'pass');
INSERT INTO `Users` (`username`, `password`)
	VALUES ('OneMoreUser', '123456');
	
	
	
	
	
	
	
