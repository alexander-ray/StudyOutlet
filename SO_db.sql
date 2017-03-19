create table if not exists `User` (
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
