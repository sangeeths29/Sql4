# Write your MySQL query statement below
WITH CTE AS (
    SELECT home_team_id AS r1, away_team_id AS r2, home_team_goals AS g1, away_team_goals AS g2
    FROM Matches
    UNION ALL
    SELECT away_team_id AS r1, home_team_id AS r2, away_team_goals AS g1, home_team_goals AS g2
    FROM Matches
)

SELECT t.team_name, COUNT(c.r1) AS matches_played, 
SUM(
    CASE
        WHEN c.g1 > c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 1
        ELSE 0
    END) AS points, SUM(c.g1) AS goal_for, SUM(c.g2) AS goal_against, SUM(c.g1) - SUM(c.g2) AS goal_diff
FROM Teams t
INNER JOIN CTE c
ON t.team_id = c.r1
GROUP BY c.r1
ORDER BY points DESC, goal_diff DESC, team_name ASC;