use SQL_assessment;
## Problem4

CREATE TABLE exams (
  exam_id int(64) NOT NULL,
  student_id int(64) NOT NULL,
  score int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO exams (exam_id, student_id, score) VALUES
(10, 1, 70),
(10, 2, 80),
(10, 3, 90),
(20, 1, 80),
(30, 1, 70),
(30, 3, 80),
(30, 4, 90),
(40, 1, 60),
(40, 2, 70),
(40, 4, 80);


CREATE TABLE students (
  student_id int(64) NOT NULL,
  student_name varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO students (student_id, student_name) VALUES
(1, 'Daniel'),
(2, 'Jade'),
(3, 'Stella'),
(4, 'Jonathan'),
(5, 'Will');

/* Write an SQL query to report the students (student_id, student_name) being quiet in all exams.
 Do not return the student who has never taken any exam.*/
 
 /* A quiet student is the one who took at least one exam and did not score the high or the low score.*/
 
 /* Query explaination: With the help of CTE, firstly extracted the only IDs which had either maximum or minimun score then
 again by using the join function with the not in operator, filtered out the ID which was not available in extracted CTE table. */ 

select * from exams;
select * from students;

with cte as
(select exam_id, min(score) as min_score, max(score) as max_score from exams group by exam_id),
cte1 as
(select e.student_id from exams as e  join cte c1 on e.exam_id = c1.exam_id where e.score = c1.min_score or e.score = c1.max_score
order by student_id)
select distinct s.student_id, s.student_name from students as s join exams as e on s.student_id = e.student_id
where s.student_id not in (select * from cte1);

