use sql_assessment;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `name`) VALUES
(1, 'Eating'),
(2, 'Singing'),
(3, 'Horse Riding');

CREATE TABLE `friends` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `activity` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friends`
--

INSERT INTO `friends` (`id`, `name`, `activity`) VALUES
(1, 'Jonathan D.', 'Eating'),
(2, 'Jade W.', 'Singing'),
(3, 'Victor J.', 'Singing'),
(4, 'Elvis Q.', 'Eating'),
(5, 'Daniel A.', 'Eating'),
(6, 'Bob B.', 'Horse Riding');

/* Write an SQL query to find the names of all the activities with neither the maximum nor the minimum number of participants.
Each activity in the Activities table is performed by any person in the table Friends.*/

/* Query explaination: With the help of CTE and join function, arrange the count of particular activity and then as
we needed netiher maximun count or minimum then by using Limit and Offset, extracted only those activity which count was 1 above from minimun
 or 1 below from maximun. */

with cte as
(select a.name as activity, count(a.name) as cnt from friends f left outer join activities a on f.activity=a.name group by activity)
select activity from cte order by cnt limit 1 offset 1;