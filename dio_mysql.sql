CREATE DATABASE dio_mysql;

CREATE TABLE `dio_mysql`.`videos` ( `id_video` INT NOT NULL AUTO_INCREMENT , `author` VARCHAR(30) NOT NULL , `title` VARCHAR(30) NOT NULL , `likes` INT NOT NULL , `deslikes` INT NOT NULL , PRIMARY KEY (`id_video`)) ENGINE = MyISAM;

INSERT INTO videos (author, title, likes, deslikes) values ('Ramon', 'Video 1', 5, 1);
INSERT INTO videos (author, title, likes, deslikes) values ('Bianca', 'Video 2', 1002, 34);
INSERT INTO videos (author, title, likes, deslikes) values ('Roger', 'Video 3', 2000345, 2456);
INSERT INTO videos (author, title, likes, deslikes) values ('Ramon', 'Video de culinaria', 50, 12);
INSERT INTO videos (author, title, likes, deslikes) values ('João', 'Video exercicio', 14562, 4);
INSERT INTO videos (author, title, likes, deslikes) values ('João', 'Video 33', 34566, 3);

CREATE TABLE `dio_mysql`.`author` ( `id_author` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(30) NOT NULL , `born` DATE NOT NULL , PRIMARY KEY (`id_author`)) ENGINE = MyISAM;

INSERT INTO author (name, born) values ('Ramon', '1996-05-07');
INSERT INTO author (name, born) values ('Bianca', '1992-12-09');
INSERT INTO author (name, born) values ('Roger', '1989-11-03');
INSERT INTO author (name, born) values ('João', '2005-09-17');

UPDATE videos
SET author='';

ALTER TABLE `videos` CHANGE `author` `author` INT NOT NULL;

UPDATE videos 
SET author=1
where id_video=1;

UPDATE videos 
SET author=1
where id_video=2;

UPDATE videos 
SET author=2
where id_video=3;

UPDATE videos 
SET author=3
where id_video=4;

UPDATE videos 
SET author=4
where id_video=5;

UPDATE videos 
SET author=3
where id_video=6;

ALTER TABLE `videos` CHANGE `author` `fk_author` INT(11) NOT NULL;

ALTER TABLE `videos` ADD CONSTRAINT `fk_author` FOREIGN KEY (`fk_author`) 
REFERENCES `author`(`id_author`) 
ON DELETE CASCADE ON UPDATE CASCADE;

--Consultas

SELECT * FROM videos JOIN author ON videos.fk_author = author.id_author; -- Trará todos os dados das tabelas juntas

SELECT videos.title, author.name FROM videos JOIN author ON videos.fk_author = author.id_author; -- Ver apenas quem postou o video e o titulo dele

--

CREATE TABLE `dio_mysql`.`seo` ( `id_seo` INT NOT NULL AUTO_INCREMENT , `category` VARCHAR(30) NOT NULL , PRIMARY KEY (`id_seo`)) ENGINE = MyISAM;

INSERT INTO seo (category) values ('Video com titulo sem identificação');
INSERT INTO seo (category) values ('Video com titulo descritivo');

ALTER TABLE `videos` ADD `fk_seo` INT NOT NULL AFTER `fk_author`;

UPDATE videos
SET fk_seo=1
where id_video = 1;

UPDATE videos
SET fk_seo=1
where id_video = 2;

UPDATE videos
SET fk_seo=1
where id_video = 3;

UPDATE videos
SET fk_seo=1
where id_video = 6;

UPDATE videos
SET fk_seo=2
where id_video = 4;

UPDATE videos
SET fk_seo=2
where id_video = 5;

ALTER TABLE `videos` ADD CONSTRAINT `fk_seo` FOREIGN KEY
(`fk_seo`)
REFERENCES `seo`(`id_seo`);

-- Mais consultas

SELECT * FROM videos JOIN seo ON fk_seo = seo.id_seo; -- Todos os dados de ambas as tabelas

SELECT videos.title, seo.category FROM videos JOIN seo ON fk_seo = seo.id_seo; -- Apenas o titulo do vídeo e sua categoria

SELECT videos.title,  author.name, seo.category FROM videos JOIN seo ON fk_seo = seo.id_seo
JOIN author ON fk_author = id_author; -- Titulo, autor e categoria juntando dados de 3 tabelas

--

CREATE TABLE `dio_mysql`.`playlist` ( `id_playlist` INT NOT NULL AUTO_INCREMENT , `name_pl` VARCHAR(20) NOT NULL , PRIMARY KEY (`id_playlist`)) ENGINE = MyISAM;

INSERT INTO playlist (name_pl) values ('Ver mais tarde');
INSERT INTO playlist (name_pl) values ('Não curti');
INSERT INTO playlist (name_pl) values ('Divertidos');

CREATE TABLE `dio_mysql`.`videos_playlist` ( `id_vp` INT NOT NULL AUTO_INCREMENT , `fk_videos` INT NOT NULL , `fk_playlist` INT NOT NULL , PRIMARY KEY (`id_vp`)) ENGINE = MyISAM;

INSERT INTO videos_playlist (fk_videos, fk_playlist) values (1,1);
INSERT INTO videos_playlist (fk_videos, fk_playlist) values (3,1);
INSERT INTO videos_playlist (fk_videos, fk_playlist) values (4,2);

-- Mais Consultas

SELECT playlist.name_pl, videos.title, author.name FROM playlist
JOIN videos_playlist ON
playlist.id_playlist = videos_playlist.fk_playlist
JOIN videos ON 
videos_playlist.fk_videos = videos.id_video
JOIN author ON videos.fk_author = author.id_author;