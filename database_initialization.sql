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
 `soulution` mediumblob not null,
 `subject` varchar(45) not null,
 `topic` varchar(45) not null,
 primary key(`question_id`)
);

create table if not exists `IncorrectQ`(
 `incorrectQ_id` int(1) not null,
 `question_id` int(1) not null,
 `user_id` int(1) not null,
 primary key(`incorrectQ_id`, `question_id` , `user_id`),
 foreign key(`user_id`) references User(`user_id`),
 foreign key(`question_id`) references Questions(`question_id`)
);

INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE(Q1.png),'A', LOAD_FILE(Q1sol.png), 'Physics', 'Mechanics');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE(Q2.png), 'D', LOAD_FILE(Q2sol.png), 'Physics', 'E&M');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE(Q3.png), 'B', LOAD_FILE(Q3sol.png), 'Physics', 'Mechanics');
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`);
	VALUES (LOAD_FILE(Q4.png), 'A', LOAD_FILE(Q4sol.png), 'Physics', 'E&M')
INSERT INTO `Questions` (`question`, `answer`, `solution`, `subject`, `topic`) 
	VALUES (LOAD_FILE(Q5.png), 'C', LOAD_FILE(Q5sol.png), 'Physics', 'Mechanics');
	
INSERT INTO `Users` (`username`, `password`)
	VALUES ('AlexRay', 'pass');
INSERT INTO `Users` (`username`, `password`)
	VALUES ('OneMoreUser', '123456');
	
	
	
	
	
	
	