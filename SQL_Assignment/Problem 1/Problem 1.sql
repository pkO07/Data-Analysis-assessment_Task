use sql_assessment;

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `match_id` int(64) NOT NULL,
  `host_team` int(64) NOT NULL,
  `guest_team` int(64) NOT NULL,
  `host_goals` int(64) NOT NULL,
  `guest_goals` int(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`id`, `match_id`, `host_team`, `guest_team`, `host_goals`, `guest_goals`) VALUES
(1, 1, 10, 20, 3, 0),
(2, 2, 30, 10, 2, 2),
(3, 3, 10, 50, 5, 1),
(4, 4, 20, 30, 1, 0),
(5, 5, 50, 30, 1, 0);

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `team_id` int(64) NOT NULL,
  `team_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `team_id`, `team_name`) VALUES
(1, 10, 'FC Barcelona'),
(2, 20, 'NewYork FC'),
(3, 30, 'Atlanta FC'),
(4, 40, 'Chicago FC'),
(5, 50, 'Toronto FC');

/* You would like to compute the scores of all teams after all matches. Points are awarded as follows:
A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team). 

Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches.
Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order. */

/* Query explaination: With the help of CTE and CASE statements, segregated the actual points scored by both host and guest teams
then again by continuing the CTE and aggregate function sum, added the points gained by host and guest team and then
by uisng UNION ALL added both the points as total_points then fetched the required field using a sub_query with the join function,  */

With score_goal as
(
SELECT *, 
CASE WHEN host_goals > guest_goals THEN 3 
WHEN host_goals = guest_goals THEN 1 
WHEN host_goals < guest_goals THEN 0 
END as host_points,
CASE WHEN host_goals < guest_goals THEN 3 
WHEN host_goals = guest_goals THEN 1 
WHEN host_goals > guest_goals THEN 0 
END as guest_points
FROM Matches
),
total_point as(
SELECT  a.TEAM_ID, SUM(a.TOTAL_PT) AS TOTAL_SCORE
FROM
( SELECT
 host_team as team_id, SUM(host_points) as total_pt FROM score_goal GROUP BY 1
 UNION ALL
 SELECT guest_team as team_id, SUM(guest_points) as total_pt FROM  score_goal GROUP BY 1
) as a
GROUP BY 1
)
SELECT distinct tm.TEAM_ID, tm.TEAM_NAME, coalesce(tp.total_score,0) as num_points
From
(select distinct team_id, team_name from Teams) as tm left join Total_point as tp
on tm.team_id=tp.team_id Order by Tp.total_score DESC, tm.TEAM_ID ASC;