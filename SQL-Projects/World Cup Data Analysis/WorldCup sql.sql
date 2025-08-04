Create database WorldCup;
use worldcup;
-- 1.Total Matches Played in the World Cup
select sum(Matches_Played) as Total_Matches_Played from world_cups;
-- 2.List All World Cup Winners
select Distinct winner from world_cups;
-- 3.Count of Matches Per Year
SELECT 
    year, COUNT(*) AS Matches_Per_Year
FROM
    world_cup_matches
GROUP BY year
ORDER BY year;
-- 4.Number of Goals Scored Per World Cup
SELECT 
    Year, SUM(Home_Goals + Away_Goals) AS total_goals
FROM
    world_cup_matches
GROUP BY Year
ORDER BY Year;

-- 5.Average Goals per Match (World Cup History)
SELECT 
    ROUND(AVG(Home_Goals + Away_Goals), 2) AS average_goals_per_match
FROM 
    world_cup_matches;
-- 6.Most Successful Teams (Based on Titles Won)
SELECT 
    winner AS Team, COUNT(winner) AS Titles_Won
FROM
    world_cups
GROUP BY winner
ORDER BY Titles_Won DESC; 
-- 7.Top 5 Goal-Scoring Players in 2022
SELECT 
    Player, Team, WC_goals AS World_Cup_Goals
FROM
    2022_world_cup_squads
ORDER BY World_Cup_Goals DESC
LIMIT 5;
-- 8. Number of Matches Hosted by Each Country
SELECT 
    home_team AS Hosted_Country,
    COUNT(home_team) AS Matches_Hosted
FROM
    world_cup_matches
WHERE
    host_team = 'True'
GROUP BY Hosted_Country
ORDER BY Matches_Hosted DESC;
-- 9.Rank Teams Based on FIFA Ranking (2022 World Cup)
SELECT 
    team,
    FIFA_Ranking,
    RANK() OVER (ORDER BY FIFA_Ranking) AS Ranking
FROM 
    2022_world_cup_groups
ORDER BY 
    Ranking;

-- 10.Highest Goal-Scoring Matches in World Cup History
SELECT 
    Year,
    Date,
    Home_Team,
    Away_Team,
    Home_Goals,
    Away_Goals,
    Home_Goals + Away_Goals AS Total_Goals
FROM
    world_cup_matches
ORDER BY Total_Goals DESC
LIMIT 10;
-- 11.Teams with the Most Finals Appearances
SELECT 
    Team, COUNT(*) AS Final_Appearances
FROM
    (SELECT 
        Home_Team AS Team
    FROM
        world_cup_matches
    WHERE
        stage = 'Final' UNION ALL SELECT 
        Away_Team AS Team
    FROM
        world_cup_matches
    WHERE stage = 'Final') AS Final_Teams
GROUP BY Team
ORDER BY final_appearances DESC;
-- 12. Finding "Giant Killers" – Lower Ranked Teams That Beat Higher Ranked Teams
SELECT 
    wcm.date AS Date,
    wcm.year AS Year,
    wcm.Home_Team AS Home_Team,
    wcm.away_team AS Away_Team,
    ht.FIFA_Ranking AS Home_Team_Rank,
    at.FIFA_Ranking AS Away_Team_Rank,
    CASE
        WHEN wcm.home_goals > wcm.away_goals THEN wcm.home_team
        WHEN wcm.away_goals > wcm.home_goals THEN wcm.away_team
        ELSE 'Draw'
    END AS Winner
FROM
    world_cup_matches AS wcm
        JOIN
    2022_world_cup_groups AS ht ON wcm.home_team = ht.team
        JOIN
    2022_world_cup_groups AS at ON wcm.away_team = at.team
WHERE
    ((wcm.home_goals > wcm.away_goals
        AND ht.FIFA_Ranking > at.FIFA_Ranking)
        OR (wcm.away_goals > wcm.home_goals
        AND at.FIFA_Ranking > ht.FIFA_Ranking));
