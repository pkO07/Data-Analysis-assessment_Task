use SQL_assessment;
CREATE TABLE `project` (
  `project_id` int(64) NOT NULL,
  `employee_id` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`project_id`, `employee_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);
COMMIT;
CREATE TABLE `employee` (
  `employee_id` int(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `experience_years` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `experience_years`) VALUES
(1, 'Suraj', 3),
(2, 'Anurag', 2),
(3, 'John', 3),
(4, 'Nikhil', 2);
COMMIT;

/* Write an SQL query that reports the most experienced employees in each project. In case of a tie,
 report all employees with the maximum number of experience years. Return the result table in any order. */

/* Query explaination: With the uses of CTE and Join function, first combined the both table and then by
 using Windows function (rank), ordered the data years of experience and then filered only those whose satisfied the mentioned conditions.*/

with cte as
(select p.project_id, e.* from project p left outer join employee e on p.employee_id=e.employee_id),
cte1 as
(select *, rank() over(order by experience_years desc) as rk from cte)
select project_id, employee_id from cte1 where rk=1;