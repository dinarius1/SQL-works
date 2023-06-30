-- 1 task
SELECT ocurance FROM wordform LIMIT 10;

-- 2 task
select plaintext from wordform where plaintext like 'a%';

-- 3 task
select title, genretype from work where genretype = 'p';

-- 4 task
select avg(totalparagraphs) as avg from work where genretype = 't';

-- 5 task
select avg(totalwords) as avg from work;
select title from work where totalwords > 20563;

-- 6 task
-- Выведите имя героя, количество его реплик и название произведения, в котором этот герой встречается(таблицы character_work и character).

-- Ожидаемый вывод:

   charname         | speechcount |     title            
--------------------+-------------+------------------------ 
First Apparition    |           1 | Macbeth 
First Citizen       |           3 | Romeo and Juliet 
First Conspirator   |           3 | Coriolanus 
First Gentleman     |           1 | Othello 
First Goth          |           4 | Titus Andronicus 
... 
(1346 row) 

select character.charname, character.speechcount, work.title 
from character join character_work on character.charid = character_work.charid join work on character_work.workid = work.workid;

--7 task
SELECT ROUND(avg(speechcount)), work.title FROM character JOIN character_work ON character.charid = character_work.charid JOIN work ON character_work.workid = work.workid WHERE work.title = 'Romeo and Juliet' GROUP BY work.title; 

-- 8 task
SELECT section, SUM(wordcount) as sum FROM paragraph GROUP BY section;

-- 9 task
select charname, speechcount from character where speechcount >= 15 and speechcount <= 30;

-- 10 task
select title, year from work where year >= 1601 and year <= 1701;

-- 11 task
select longtitle from work where longtitle like '%the%';

-- 12 task
select distinct section from paragraph;

-- 13 task
select chapter.chapterid, chapter.description, work.title
from chapter join work
on chapter.workid = work.workid;

-- 14 task
select paragraph.paragraphnum, character.charname, character.speechcount
from paragraph join character
on character.charid = paragraph.charid;

-- 15 task
select paragraph.paragraphnum, work.title, work.year
from paragraph join work on paragraph.workid = work.workid;
